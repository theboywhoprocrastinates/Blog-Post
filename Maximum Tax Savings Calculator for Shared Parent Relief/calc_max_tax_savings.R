calc_tax = function(income) {
  if (income <= 22000) {
    tax = 0
  } else if (income > 22000 & income <= 30000) {
    tax = (income - 20000) * 0.02
  } else if (income > 30000 & income <= 40000) {
    tax = (income - 30000) * 0.035 + 200
  } else if (income > 40000 & income <= 80000) {
    tax = (income - 40000) * 0.07 + 550
  } else if (income > 80000 & income <= 120000) {
    tax = (income - 80000) * 0.115 + 3350
  } else if (income > 120000 & income <= 160000) {
    tax = (income - 120000) * 0.15 + 7950
  } else if (income > 160000 & income <= 200000) {
    tax = (income - 160000) * 0.18 + 13950
  } else if (income > 200000 & income <= 240000) {
    tax = (income - 200000) * 0.19 + 21150
  } else if (income > 240000 & income <= 280000) {
    tax = (income - 240000) * 0.195 + 28750
  } else if (income > 280000 & income <= 320000) {
    tax = (income - 280000) * 0.2 + 36550
  } else if (income > 320000) {
    tax = (income - 320000) * 0.22 + 44550
  }
  return (tax)
}

calc_max_tax_savings = function(income1,income2,relief) {
  max_tax_savings = 0
  df=data.frame()
  for (i in 0:relief) {
    tax_savings1 = calc_tax(income1) - calc_tax(income1 - i)
    tax_savings2 = calc_tax(income2)- calc_tax(income2 - relief + i)
    total_tax_savings = tax_savings1 + tax_savings2
    max_tax_savings = max(max_tax_savings, total_tax_savings)
  }
  
  for (i in 0:relief) {
    tax_savings1 = calc_tax(income1) - calc_tax(income1 - i)
    tax_savings2 = calc_tax(income2)- calc_tax(income2 - relief + i)
    total_tax_savings = tax_savings1 + tax_savings2
    if (round(max_tax_savings,3) == round(total_tax_savings,3)) {
      df = rbind(df, c(i,relief-i))
    }
  }
  colnames(df) = c("Relief to be claimed by Person 1","Relief to be claimed by Person 2")
  result = list("max" = max_tax_savings, "table" = df)
  return(result)
}