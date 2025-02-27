/*Drop Tables*/
DROP TABLE IF EXISTS LIVE_SESSION;
DROP TABLE IF EXISTS ASSESSMENT;
DROP TABLE IF EXISTS STUDENT_ASSIGNMENT;
DROP TABLE IF EXISTS STUDENT_BATCH;
DROP TABLE IF EXISTS MODULE_TEACHER_ASSIGNMENT;
DROP TABLE IF EXISTS BATCH;
DROP TABLE IF EXISTS TOPIC_DETAILS;
DROP TABLE IF EXISTS TOPIC;
DROP TABLE IF EXISTS MODULE;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS PARENT_DETAILS;
DROP TABLE IF EXISTS USER_CREDENTIALS;
DROP TABLE IF EXISTS USER;

/*USER*/
CREATE TABLE IF NOT EXISTS USER(
USER_ID INT AUTO_INCREMENT PRIMARY KEY,
USER_TYPE CHAR(1),
FIRST_NAME VARCHAR(25),
MIDDLE_NAME VARCHAR(25),
LAST_NAME VARCHAR(25),
GENDER CHAR(1),
DOB DATE,
ADDRESS1 VARCHAR(100),
ADDRESS2 VARCHAR(100),
CITY VARCHAR(25),
STATE VARCHAR(25),
COUNTRY VARCHAR(25),
MOBILE VARCHAR(20),
MAIL_ID VARCHAR(25),
CREATED_ON DATE 
);

/*USER_CREDENTIALS*/
CREATE TABLE IF NOT EXISTS USER_CREDENTIALS(
USER_ID INT AUTO_INCREMENT PRIMARY KEY,
USER_NAME VARCHAR(25),
PASSWORD VARCHAR(25),
LAST_LOGIN_DT DATE,
USER_STATUS VARCHAR(10),
CONSTRAINT fk_userId
    FOREIGN KEY (USER_ID) 
        REFERENCES USER(USER_ID)
);

/*PARENT_DETAILS*/
CREATE TABLE IF NOT EXISTS PARENT_DETAILS(
STUDENT_ID INT AUTO_INCREMENT PRIMARY KEY,
PARENT_FIRST_NAME VARCHAR(25),
PARENT_MIDDLE_NAME VARCHAR(25),
PARENT_LAST_NAME VARCHAR(25),
RELATION_TO_STUDENT VARCHAR(25),
PARENT_MOBILE VARCHAR(20),
PARENT_MAIL_ID VARCHAR(25),
CONSTRAINT fk_studentId
    FOREIGN KEY (STUDENT_ID) 
        REFERENCES USER(USER_ID)
);

/*COURSE*/
CREATE TABLE IF NOT EXISTS COURSE(
COURSE_ID INT AUTO_INCREMENT PRIMARY KEY,
COURSE_NAME VARCHAR(100),
DURATION_IN_MONTH int
);

/*MODULE*/
CREATE TABLE IF NOT EXISTS MODULE(
MODULE_ID INT AUTO_INCREMENT PRIMARY KEY,
MODULE_NAME VARCHAR(100),
COURSE_ID INT,
CONSTRAINT fk_courseId
    FOREIGN KEY (COURSE_ID) 
        REFERENCES COURSE(COURSE_ID)
);

/*TOPIC*/
CREATE TABLE IF NOT EXISTS TOPIC(
TOPIC_ID INT AUTO_INCREMENT PRIMARY KEY,
TOPIC_NAME VARCHAR(50),
MODULE_ID INT,
SEQ_NO INT,
PAGE_LINK VARCHAR(100),
CONSTRAINT fk_moduleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID)
);

/*TOPIC_DETAILS*/
CREATE TABLE IF NOT EXISTS TOPIC_DETAILS(
TOPIC_DETAILS_ID INT AUTO_INCREMENT PRIMARY KEY,
TOPIC_DESCRIPTION VARCHAR(100),
TOPIC_ID INT,
SEQ_NO INT,
PAGE_LINK VARCHAR(100),
CONSTRAINT fk_topicId
    FOREIGN KEY (TOPIC_ID) 
        REFERENCES TOPIC(TOPIC_ID)
);

/*FILE*/
CREATE TABLE IF NOT EXISTS FILE (
  FILE_ID INT AUTO_INCREMENT PRIMARY KEY,
  FILE_NAME VARCHAR(45),
  FILE_TYPE VARCHAR(5) NOT NULL,
  DATA LONGBLOB
);

/*BATCH*/
CREATE TABLE IF NOT EXISTS BATCH(
BATCH_ID INT AUTO_INCREMENT PRIMARY KEY,
COURSE_ID INT,
BATCH_NAME VARCHAR(25),
START_DATE DATE,
END_DATE DATE,
CONSTRAINT fk_batchCourseId
    FOREIGN KEY (COURSE_ID) 
        REFERENCES COURSE(COURSE_ID)
);

/*MODULE_TEACHER_ASSIGNMENT*/
CREATE TABLE IF NOT EXISTS MODULE_TEACHER_ASSIGNMENT(
MAPPING_ID INT AUTO_INCREMENT PRIMARY KEY,
BATCH_ID INT,
MODULE_ID INT,
TEACHER_ID INT,
CONSTRAINT fk_batchId
    FOREIGN KEY (BATCH_ID) 
        REFERENCES BATCH(BATCH_ID),
CONSTRAINT fk_moduleTeacherAssId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID),
CONSTRAINT fk_teacherId
    FOREIGN KEY (TEACHER_ID) 
        REFERENCES USER(USER_ID)
);

/*STUDENT_BATCH*/
CREATE TABLE IF NOT EXISTS STUDENT_BATCH(
STUDENT_BATCH_ID INT AUTO_INCREMENT PRIMARY KEY,
BATCH_ID INT,
STUDENT_ID INT,
ATTENDANCE VARCHAR(5),
COMPLETION_STATUS VARCHAR(10),
CONSTRAINT fk_studentBatchId
    FOREIGN KEY (BATCH_ID) 
        REFERENCES BATCH(BATCH_ID),
CONSTRAINT fk_studentUserId
    FOREIGN KEY (STUDENT_ID)
        REFERENCES USER(USER_ID)
);

/*STUDENT_ASSIGNMENT*/
CREATE TABLE IF NOT EXISTS STUDENT_ASSIGNMENT(
STUDENT_BATCH_ID INT,
MODULE_ID INT,
TOPIC_ID INT,
DATE_ASSIGNED DATE,
DUE_DATE DATE,
COMPLETION_STATUS VARCHAR(10),
CONSTRAINT fk_studentAssBatchId
    FOREIGN KEY (STUDENT_BATCH_ID)
        REFERENCES STUDENT_BATCH(STUDENT_BATCH_ID),
CONSTRAINT fk_studentAssModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID),
CONSTRAINT fk_studentAssTopicId
    FOREIGN KEY (TOPIC_ID) 
        REFERENCES TOPIC_DETAILS(TOPIC_ID)
);

/*ASSESSMENT*/
CREATE TABLE IF NOT EXISTS ASSESSMENT(
ASSESSMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
STUDENT_BATCH_ID INT,
MODULE_ID INT,
NAME VARCHAR(25),
ASSESSMENT_DATE DATE,
MARKS INT(10),
CONSTRAINT fk_assStudentBatchId
    FOREIGN KEY (STUDENT_BATCH_ID)
        REFERENCES STUDENT_BATCH(STUDENT_BATCH_ID),
CONSTRAINT fk_assModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID)
);

/*LIVE_SESSION*/
CREATE TABLE IF NOT EXISTS LIVE_SESSION(
SESSION_ID INT AUTO_INCREMENT PRIMARY KEY,
BATCH_ID INT,
MODULE_ID INT,
TEACHER_ID INT,
SESSION_DATE DATE,
STATUS VARCHAR(10),
CONSTRAINT fk_sessionBatchId
    FOREIGN KEY (BATCH_ID) 
        REFERENCES BATCH(BATCH_ID),
CONSTRAINT fk_sessionModuleId
    FOREIGN KEY (MODULE_ID) 
        REFERENCES MODULE(MODULE_ID),
CONSTRAINT fk_sessionUserId
    FOREIGN KEY (TEACHER_ID) 
        REFERENCES USER(USER_ID)
);