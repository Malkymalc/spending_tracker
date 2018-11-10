require_relative( "../models/category_group.rb" )
require_relative( "../models/category.rb" )
require_relative( "../models/time_period.rb" )
require_relative( "../models/transaction.rb" )
require("pry-byebug")

Transaction.delete_all()
TimePeriod.delete_all()
Category.delete_all()
CategoryGroup.delete_all()

#Category Group
category_group1 = CategoryGroup.new({
  "name" => "Income",
  "colour" => "#adf352",
  })
category_group1.save()

category_group2 = CategoryGroup.new({
  "name" => "Saving",
  "colour" => "#d58291",
  })
category_group2.save()

category_group3 = CategoryGroup.new({
  "name" => "Debt Repayment",
  "colour" => "#2845ac",
  })
category_group3.save()

category_group4 = CategoryGroup.new({
  "name" => "Household",
  "colour" => "#7930ba",
  })
category_group4.save()

category_group5 = CategoryGroup.new({
  "name" => "Giving",
  "colour" => "#2319cb",
  })
category_group5.save()

category_group6 = CategoryGroup.new({
  "name" => "Quality of Life",
  "colour" => "#56da3f",
  })
category_group6.save()

category_group7 = CategoryGroup.new({
  "name" => "Goals",
  "colour" => "#ffc57a",
  })
category_group7.save()

#Category
category1 = Category.new({
  "name" => "Rent / Mortgage",
  "category_group_id" => "4",
  })
category1.save()

category2 = Category.new({
  "name" => "Electricity",
  "category_group_id" => "4",
  })
category2.save()

category3 = Category.new({
  "name" => "Local Tax",
  "category_group_id" => "4",
  })
category3.save()

category4 = Category.new({
  "name" => "Birthdays",
  "category_group_id" => "5",
  })
category4.save()

category5 = Category.new({
  "name" => "Charity",
  "category_group_id" => "5",
  })
category5.save()

category6 = Category.new({
  "name" => "Cinema",
  "category_group_id" => "6",
  })
category6.save()

category7 = Category.new({
  "name" => "Clothing",
  "category_group_id" => "6",
  })
category7.save()

category8 = Category.new({
  "name" => "Fitness",
  "category_group_id" => "6",
  })
category8.save()

category9 = Category.new({
  "name" => "Education",
  "category_group_id" => "7",
  })
category9.save()

category10 = Category.new({
  "name" => "Travel",
  "category_group_id" => "7",
  })
category10.save()
