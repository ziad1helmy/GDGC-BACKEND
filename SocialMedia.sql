CREATE DATABASE SocialMedia;
USE SocialMedia;

CREATE TABLE Users (
    User_id INT IDENTITY PRIMARY KEY,
    User_Name NVARCHAR(100) UNIQUE NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female')) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Join_Date DATETIME DEFAULT GETUTCDATE(),
    Date_Of_Birth DATETIME NOT NULL
);

CREATE TABLE Posts (
    Post_ID INT IDENTITY PRIMARY KEY,
    Post_Date DATETIME DEFAULT GETUTCDATE(),
    Content NVARCHAR(350) NOT NULL,
    Visibility NVARCHAR(3) CHECK (Visibility IN ('Yes', 'No')),
    UserId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(User_Id)
);

CREATE TABLE Reactions (
    React_Id INT IDENTITY PRIMARY KEY,
    React_Type NVARCHAR(50) CHECK (React_Type IN ('Love', 'Care', 'Like', 'Sad')),
    React_Date DATETIME DEFAULT GETUTCDATE(),
    UserId INT NOT NULL,
    PostId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(User_Id),
    FOREIGN KEY (PostId) REFERENCES Posts(Post_ID)
);

CREATE TABLE Comments (
    Comment_Id INT IDENTITY PRIMARY KEY,
    Comment_Date DATETIME DEFAULT GETUTCDATE(),
    Comment_content NVARCHAR(300) NOT NULL,
    CommentUser_ID INT NOT NULL,
    CommentPost_ID INT NOT NULL,
    FOREIGN KEY (CommentUser_ID) REFERENCES Users(User_Id),
    FOREIGN KEY (CommentPost_ID) REFERENCES Posts(Post_ID)
);

--data from chat gpt 
INSERT INTO Users (User_Name, Gender, Email, Date_Of_Birth)
VALUES ('JohnDoe', 'Male', 'johndoe@example.com', '1995-08-15');

INSERT INTO Users (User_Name, Gender, Email, Date_Of_Birth)
VALUES ('JaneSmith', 'Female', 'janesmith@example.com', '1998-05-22');

INSERT INTO Posts (Content, Visibility, UserId)
VALUES ('Hello, world! This is my first post.', 'Yes', 1);

INSERT INTO Posts (Content, Visibility, UserId)
VALUES ('Good morning everyone! Have a great day!', 'Yes', 2);

INSERT INTO Reactions (React_Type, UserId, PostId)
VALUES ('Like', 2, 1);

INSERT INTO Reactions (React_Type, UserId, PostId)
VALUES ('Love', 1, 2);

INSERT INTO Comments (Comment_content, CommentUser_ID, CommentPost_ID)
VALUES ('Nice post, John!', 2, 1);

INSERT INTO Comments (Comment_content, CommentUser_ID, CommentPost_ID)
VALUES ('Thanks, Jane!', 1, 2);

DROP TABLE SocialMedia.dbo.Users;
DROP DATABASE SocialMedia;