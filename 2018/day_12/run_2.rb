=begin
See run_1 for algortithm: 

80(15873) ..............####.##.###.##.################################################################################################################################################################........................................
81(16052) ...............##.##.###.##.##################################################################################################################################################################.......................................
82(16236) ...............#.##.###.##.####################################################################################################################################################################...................................... 
83(16430) ..............####.###.##.######################################################################################################################################################################.....................................
84(16611) ...............##.###.##.########################################################################################################################################################################....................................
85(16797) ...............#.###.##.##########################################################################################################################################################################................................... 
86(16993) ..............#####.##.############################################################################################################################################################################..................................
87(17176) ...............###.##.##############################################################################################################################################################################.................................
88(17359) ................#.##.################################################################################################################################################################################................................
89(17559) ...............####.##################################################################################################################################################################################...............................
90(17743) ................##.####################################################################################################################################################################################..............................
91(17933) ................#.######################################################################################################################################################################################.............................
92(18135) ...............##########################################################################################################################################################################################............................
93(18321) ................##########################################################################################################################################################################################...........................
94(18507) .................##########################################################################################################################################################################################..........................
95(18693) ..................##########################################################################################################################################################################################.........................
96(18879) ...................##########################################################################################################################################################################################........................
97(19065) ....................##########################################################################################################################################################################################.......................
98(19251) .....................##########################################################################################################################################################################################......................
99(19437) ......................##########################################################################################################################################################################################.....................
100(19623).......................##########################################################################################################################################################################################....................

constant growth of the sum of 186 per generation after generation 92
So function is:
 18135 + (n - 92) * 186
=end


def assumed_sum(n)
  18135 + (n - 92) * 186
end

puts assumed_sum(50000000000)