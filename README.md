# Poster_juges_assignment
This contains MATLAB code for randomly assign judges to poster.
File name: CEGS_judges_allocation.m
%%this code will assign judges completely at random without bias. this function takes
%%three INPUT arguments 
%%no_of_posters=total number of posters/ total number of participants 
%%no_of_judges=total number of judges who registered for judging.
%%no_of_jud_per_post= total number of judges who will judge each poster.
%%example: typically each poster was judged by 3 different judges.
%%3 OUTPUT arguments
%%1. judge_number_for_each_poster= this will help us know which judge is
%%assigned for which poster.
%%2. poster_no_for_each_judge= this will help while preparing for judging
%%sheets and gives judges idea about which poster they should visit.
%%3. No_of_poster_for_each_judge = this will give us idea about if any judge
%%has been alloted more than max number of posters one shall judge after
%%distribution of posters.
%%4. Max_poster_for_each_judge = max number of poster any one judge shall
%%be assigned to judge (IDEALLY)

File name: names for judges
This code will generate a new EXCEL file named 'Compiled data.xlsx' with all the required information and judges numbers allocated to different posters. it uses the function CEGS_judges_allocation.m file.
Next if names of the judges and poster presenters are placed in given format. this code will further assign names and other information of participants so that a judge can check for confilict of interest. Example for format of excel file with name has be uploaded. 
