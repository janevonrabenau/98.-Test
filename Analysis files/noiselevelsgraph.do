gen time_dmy = clock(time, "hms")
gen hour = hh(time_dmy)
gen minute = mm(time_dmy) 

gen hr_asleep = 1 if hour ==22
replace hr_asleep = 2 if hour ==23
replace hr_asleep = 3 if hour ==1
replace hr_asleep = 4 if hour ==2
replace hr_asleep = 5 if hour ==3
replace hr_asleep = 6 if hour ==4
replace hr_asleep = 7 if hour ==5
replace hr_asleep = 8 if hour ==6
replace hr_asleep = 9 if (hour ==7)
bysort hr_asleep: sum value
histogram value if (hour>=22 | hour<7 | (hour==7 & minute < 30))

collapse (mean) value (min) minvalue=value (max) maxvalue=value (p25) p25_value=value (p75) p75_value=value (median) p50_valuev=value, by(hour)

gen hour_mask = 1 if hour ==19
replace hour_mask = 2 if hour ==20
replace hour_mask = 3 if hour ==21
replace hour_mask = 4 if hour ==22
replace hour_mask = 5 if hour ==23
replace hour_mask = 6 if hour ==0
replace hour_mask = 7 if hour ==1
replace hour_mask = 8 if hour ==2
replace hour_mask = 9 if hour ==3
replace hour_mask = 10 if hour ==4
replace hour_mask = 11 if hour ==5
replace hour_mask = 12 if hour ==6
replace hour_mask = 13 if hour ==7
replace hour_mask = 14 if hour ==8
replace hour_mask = 15 if hour ==9
replace hour_mask = 16 if hour ==10

sort hour_mask
line minvalue hour_mask, lcolor(black) lpattern(dot) || line value hour_mask, lcolor(red) || line maxvalue hour_mask, xlabel(1 "19" 2 "20" 3 "21" 4 "22" 5 "23" 6 "0" 7 "1" 8 "2" 9 "3" 10 "4" 11 "5" 12 "6" 13 "7" 14 "8" 15 "9" 16 "10") xtitle("Time") ytitle("db level") legend(col(3) label(1 "min") label(2 "mean") label(3 "max")) title("Noise levels") lcolor(black) lpattern(dot) 

line minvalue hour_mask, lcolor(black) lpattern(dot) || line p25_value hour_mask, lcolor(blue) lpattern(dash) || line value hour_mask, lcolor(red) || line p75_value hour_mask, lcolor(blue) lpattern(dash) ||  line maxvalue hour_mask, xlabel(1 "19" 2 "20" 3 "21" 4 "22" 5 "23" 6 "0" 7 "1" 8 "2" 9 "3" 10 "4" 11 "5" 12 "6" 13 "7" 14 "8" 15 "9" 16 "10") xtitle("Time") ytitle("db level") legend(col(3) label(1 "min") label(2 "p25") label(3 "mean") label (4 "p75") label (5 "max")) title("Noise levels") lcolor(black) lpattern(dot) 


