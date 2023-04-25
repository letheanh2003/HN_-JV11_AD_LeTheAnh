create table QuanlySinhVien;
 use QuanlySinhVien;
 
 create table Subjects(
 SubjectID int primary key auto_increment,
 SubjectName varchar(50)
 );
 create table Students(
 StudentID int primary key auto_increment,
 StudentName varchar(50),
 Age int,
 Email varchar(100)
 );
 
 create table Marks(
 Mark int ,
 `SubjectID` int,
 foreign key (`SubjectID`) references Subjects(SubjectID),
 `StudentID` int,
 foreign key (`StudentID`) references Students(StudentID)
 );
 
 create table Classes(
 ClassId int primary key auto_increment,
 ClassName varchar(50)
 );
 
 create table ClassStudent(
 `StudentId` int,
  foreign key (`StudentId`) references Students(StudentID),
  `ClassId` int,
  foreign key (`ClassId`) references Classes(ClassId)
 );
 
 insert into Students(StudentName,Age,Email) values
 ("Nguyen Quang An",18,"an@yahoo.com"),
 ("Nguyen Cong Vinh",20,"vinh@gmail.com"),
 ("Nguyen Van Quyen",19,"quyen"),
 ("Pham Thanh Binh",25,"binh@com"),
 ("Nguyen Van Tai Em",35,"taiem@sport.vn");
 
 insert into Classes(ClassName) values
 ("C0706L"),("C0708G");
 
 insert into ClassStudent(StudentID,ClassId) values
 (1,1),(2,1),(3,2),(4,2),(5,2);
 
 insert into Subjects(SubjectName) values
 ("SQL"),("Java"),("C"),("Visual Basic");
 
 insert into Marks values
 (8,1,1),
 (4,2,1),
 (9,1,1),
 (7,1,3),
 (3,1,4),
 (5,2,5),
 (8,3,3),
 (1,3,5),
 (3,2,4);
 
 -- 1 ========== Hiện thị danh sách tất cả các học viên ===========
 select * from students;
 -- 2 ========== Hiện thị danh sách tất cả các môn học ===========
 select * from subjects;
 -- 3 ========== Tính điểm trung bình  ==========
 select m.StudentID, AVG(Mark) as `Điểm trung bình`
 from Marks m
 group by StudentId;
 -- 4 ========= Hiện thị môn học nào có học sinh thi được điểm cao nhất ========
select Subjects.SubjectName,max(Marks.Mark) as `Điểm cao nhất`
from Marks
join Subjects on Marks.SubjectID = Subjects.SubjectID
where Marks.Mark = (select max(Mark) from Marks)
group by Subjects.SubjectName;
-- 5 ========== Danh sách số thứ tự của điểm theo chiều giảm ============
select * from Marks order by Mark desc;
-- 6 ========== Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max) ========
alter table Subjects modify SubjectName nvarchar(255); 
-- 7 ==========  Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot SubjectName trong bang Subjects =======
update Subjects set SubjectName = concat("Đây là môn học",SubjectName);
-- 8 ========== Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table Students modify Age int check (Age > 15 and Age < 50);
-- 9 ========= Loai bo tat ca quan he giua cac bang =========
alter table ClassStudent
drop foreign key ClassStudent_ibfk_1,
drop foreign key ClassStudent_ibfk_2;
alter table Marks
drop foreign key Marks_ibfk_1,
drop foreign key Marks_ibfk_2;
-- 10 ======= Xoa hoc vien co StudentID la 1 ========= 
delete from Students where StudentID = 1;
-- 11 ======= Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table Students 
add column status bit default(1);
-- 12 ======= Cap nhap gia tri Status trong bang Student thanh 0 ========= 
update Students set `status`= 0;