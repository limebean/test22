class Price < ApplicationRecord
  belongs_to :teacher

  CHILD_TIME = { 'Full Day, 1-18 months': 0, 'Full Day, 18-30 months': 1, 'Full Day, 31-72 months': 2, 'Half Day, 1-18 months': 3, 'Half Day, 18-30 months': 4, 'Half Day, 31-72 months': 5, 'Night Time, 1-18 months': 6, 'Night Time, 18-30 months': 7, 'Night Time, 31-72 months': 8 }
  MONTH = {

  }

  enum child_time: CHILD_TIME

  def self.calculate_price(enrollment, parent_id, stripe_token)
    enrollment = Enrollment.find(enrollment)
    child = enrollment.child
    date_of_birth = child.date_of_birth.to_date
    day = enrollment.weekdays_and_time.split(',')
    parent = child.parent
    teacher = enrollment.teacher
    child_time  = find_child_time(day[1], date_of_birth)
    amount = teacher.prices.find_by(child_time: child_time).send(day[0])
    fee = teacher.teacher_profile.transaction_fee ? teacher.teacher_profile.transaction_fee : 0
    parent_payment(parent, teacher, (amount* 100), (fee * 100), stripe_token, enrollment)
  end

  def self.find_child_time(day, date_of_birth)
    months = TimeDifference.between(Date.today, date_of_birth).in_months
    result = if months >= 0 && months <= 18
      '1-18 months'
    elsif months > 18 && months <= 30
      '18-30 months'
    elsif months > 30 && months <= 72
      '31-72 months'
    end
    "#{day}, #{result}"
  end

  def self.parent_payment(parent, teacher, amount, fee, stripe_token, enrollment)
    if parent.stripe_customer_id
      customer = Stripe::Customer.retrieve(parent.stripe_customer_id)
      customer.source = stripe_token
      customer.save
    else
      customer = Stripe::Customer.create(
        email: parent.email,
        source: stripe_token
      )
      parent.update_attributes(stripe_customer_id: customer.id)
    end

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: amount.to_i,
      description: parent.email,
      currency: 'usd',
      capture: true,
      destination: {
        account: teacher.teacher_profile.stripe_account_id,
        amount: (amount - fee).to_i
      }
    })
    end_date = enrollment.start_date.to_date + 7
    Payment.create!(parent_id: parent.id, teacher_id: teacher.id, start_date: enrollment.start_date, end_date: end_date, amount: amount, enrollment_id: enrollment.id)
  end

end
