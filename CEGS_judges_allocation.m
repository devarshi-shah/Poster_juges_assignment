function[judge_number_for_each_poster,poster_no_for_each_judge,No_of_poster_for_each_judge, Max_poster_for_each_judge,total_no_of_judges_sheet]=CEGS_judges_allocation(no_of_posters,no_of_judges, no_of_jud_per_post)
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




%% calculations

n_p=no_of_posters*no_of_jud_per_post;
n_jp=floor(n_p/no_of_judges);    %max poster for a judge
n_jp1=ceil(n_p/no_of_judges);    %minimum posters for a judge
judge_number_for_each_poster=zeros(no_of_posters,no_of_jud_per_post);    %poster judges
jud_list=[1:no_of_judges]';
Max_poster_for_each_judge=n_jp1;
%unique random numbers for each poster
for i=1:no_of_posters
    judge_number_for_each_poster(i,:)=randperm(size(jud_list,1),no_of_jud_per_post); %random assignment of 3 judge to all poster
end

xxx=1;
%initial min judges check
while xxx==1
    low=[];
    high=[];
    m_high=[];
    for i=1:no_of_judges
        n_post_jud(i,1)=size(find(judge_number_for_each_poster==i),1);
        if  n_post_jud(i,1)<n_jp
            low(i,1)=n_post_jud(i,1);
        elseif n_post_jud(i,1)>n_jp1
            high(i,1)=n_post_jud(i,1);
        elseif n_post_jud(i,1)==n_jp1
            m_high(i,1)=n_post_jud(i,1);
        end
    end

    idl=find(low);
    if isempty(idl)
        break;
    end
    idh=find(high);
    if isempty(idh)
        high=m_high;
        idh=find(high);
    end
   dif=n_jp-low(idl,1);
   for k=1:size(dif,1)
        rn1=randi(size(idh,1),dif(k,1),1);
        for kk=1:size(rn1,1)
            nn=1;
            [rj_n,cj_n]=find(judge_number_for_each_poster==(idh(rn1(kk,1),1)));
           %     llll(k,1)=size(rj_n,1);
            while nn==1
                rn2=randi(size(rj_n,1),1,1);
                if isempty(find(judge_number_for_each_poster(rj_n(rn2,1),:)==idl(k,1),1))
                    high(judge_number_for_each_poster(rj_n(rn2,1),cj_n(rn2,1)),1)=high(judge_number_for_each_poster(rj_n(rn2,1),cj_n(rn2,1)),1)-1;
                    judge_number_for_each_poster(rj_n(rn2,1),cj_n(rn2,1))=idl(k,1);
                    
                    nn=0;
                else
                    continue;
                end
            end
        end
        
        %[hi_l,~]=find(high>n_jp);
        high(find(high<=n_jp))=0;        
        %high=high(hi_l,1);
        idh=find(high);
   end
    
end
    
%%check for max judges
les_j=find(n_post_jud<n_jp1);
les_j=les_j((randperm(length(les_j))),1);
while xxx==1
    low=[];
    high=[];
    m_high=[];
    poster_no_for_each_judge=zeros(no_of_judges,n_jp1);
     for i=1:no_of_judges
            n_post_jud(i,1)=size(find(judge_number_for_each_poster==i),1);
            [poster_no_for_each_judge(i,1:n_post_jud(i,1)),~]=find(judge_number_for_each_poster==i);
            if  n_post_jud(i,1)<n_jp
                low(i,1)=n_post_jud(i,1);
            elseif n_post_jud(i,1)>n_jp1
                high(i,1)=n_post_jud(i,1);
            elseif n_post_jud(i,1)==n_jp1
                m_high(i,1)=n_post_jud(i,1);
            end
     end
     idh=find(high);
     
     if isempty(idh)
         break;
     end
     
    for j=1:size(idh,1)
        dif1=high(idh(j,1),1)-n_jp1;
        [rj_n,cj_n]=find(judge_number_for_each_poster==(idh(j,1)));
        for kk=1:dif1
           % rn1=randi(size(idh,1),dif1(k,1),1);
            nn=1;        
            while nn==1
                    rn2=randi(size(rj_n,1),1,1);
                    if isempty(find(judge_number_for_each_poster(rj_n(rn2,1),:)==les_j(1,1),1))
                        high(judge_number_for_each_poster(rj_n(rn2,1),cj_n(rn2,1)),1)=high(judge_number_for_each_poster(rj_n(rn2,1),cj_n(rn2,1)),1)-1;
                        judge_number_for_each_poster(rj_n(rn2,1),cj_n(rn2,1))=les_j(1,1);                    
                        nn=0;
                    else
                        continue;
                    end
            end
            les_j=les_j(2:end,:);
        end
    end
end    
No_of_poster_for_each_judge=n_post_jud;
total_no_of_judges_sheet=n_p;
if n_p==sum(n_post_jud)
    disp('Results printed');
else
    disp('check judges total try re-running program');
end
