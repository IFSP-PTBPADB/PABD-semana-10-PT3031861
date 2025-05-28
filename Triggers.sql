CREATE TRIGGER dbo.lost_credits
ON takes
AFTER INSERT, DELETE
AS
  
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE s
        SET s.tot_cred = s.tot_cred + c.credits
        FROM dbo.student s
        INNER JOIN inserted i ON s.ID = i.ID
        INNER JOIN dbo.course c ON i.course_id = c.course_id;
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE s
        SET s.tot_cred = s.tot_cred - c.credits
        FROM dbo.student s
        INNER JOIN deleted d ON s.ID = d.ID
        INNER JOIN dbo.course c ON d.course_id = c.course_id;
    END
      
END;
