function [lesson_avg, student_gpa] = grade_analyzer(scores, student_ids)
    % scores: matrice 10x5 ()
    % student_ids: شماره دانشجویی
    
    % میانگین نمرات هر درس (میانگین ستون‌ها)
    lesson_avg = mean(scores, 1);
    
    % معدل هر دانشجو (میانگین سطرها)
    student_gpa = mean(scores, 2);
    
    % نمایش نتایج
    disp('lesson_avg:');
    disp(lesson_avg);
    disp('Each Student:');
    for i = 1:length(student_ids)
        disp(['Student ID ', num2str(student_ids(i)), ' GPA: ', num2str(student_gpa(i))]);
    end
end