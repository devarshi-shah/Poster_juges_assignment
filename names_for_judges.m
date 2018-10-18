% %% this code can be used to assign poster presenters names to poster number of the judges giving comipled list.
% 
clear all

no_of_posters=146;
no_of_judges=80;
no_of_jud_per_post=3;

final_filename='Compiled data.xlsx';
[judge_number_for_each_poster,poster_no_for_each_judge,No_of_poster_for_each_judge, Max_poster_for_each_judge,total_no_of_judges_sheet]=CEGS_judges_allocation(no_of_posters,no_of_judges, no_of_jud_per_post);

judge_number_for_each_poster=[[1:size(judge_number_for_each_poster,1)]' judge_number_for_each_poster];
judges_no_each_poster=[{'Poster No.','Judge-1','Judge-2','Judge-3'};num2cell(judge_number_for_each_poster)];

poster_no_for_each_judge=[[1:size(poster_no_for_each_judge,1)]' poster_no_for_each_judge];
poster_no_for_judges=[{'Judge No.','Poster-1','Poster-2','Poster-3','Poster-4','Poster-5','Poster-6'};num2cell(poster_no_for_each_judge)];

compiled_data={'Total number of judges',no_of_judges;'Total number of posters',no_of_posters;'Number of judges per poster',no_of_jud_per_post;'Total number of judges sheet required',total_no_of_judges_sheet;'Max number of poster for a judge',Max_poster_for_each_judge};

xlswrite(final_filename,compiled_data,'Summary');
xlswrite(final_filename,judges_no_each_poster,'For_Presenters');
xlswrite(final_filename,poster_no_for_judges,'For_Judges');


%%
file_name='GERS2018AllParticipants.xlsx';

[~,~,raw1] = xlsread(file_name,'Presenters','A1:H147');
raw1=raw1(:,[1:6 8]);
raw11=raw1(2:end,:);
[~,~,raw2] = xlsread(file_name,'Judges','A1:E81');

p=poster_no_for_each_judge;
titls=[raw2(1,:), raw1(1,:)];
xlswrite(final_filename,titls,'Presenter_names_for_judges','A1:L1');
s1=1;
for i=1:size(poster_no_for_each_judge,1)
    dat=[];
    s2=s1;
    for j=2:size(poster_no_for_each_judge,2)
        if p(i,j)~=0
            
            dat=[dat;raw2(i+1,:),raw11(p(i,j),:)];
           s2=s2+1;
        end
         
    end
    str=sprintf('A%d:L%d',s1+1,s2);
         xlswrite(final_filename,dat,'Presenter_names_for_judges',str);
         s1=s2;i
end