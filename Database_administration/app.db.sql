;
CREATE TABLE IF NOT EXISTS Products (
	ProductId	INTEGER NOT NULL,
	FileName	TEXT NOT NULL,
	Price		FLOAT,
	PRIMARY KEY(ProductId)
);
;
CREATE TABLE IF NOT EXISTS Photos (
	PhotoId	INTEGER NOT NULL,
	ProductId	INTEGER,
	FileName	TEXT NOT NULL,
	PRIMARY KEY(PhotoId),
	CONSTRAINT FK_Photos_Products FOREIGN KEY(ProductId) REFERENCES Products(ProductId)
);
;
CREATE TABLE IF NOT EXISTS Users (
	UserId	INTEGER NOT NULL,
	UserName	TEXT NOT NULL,
	Email	TEXT NOT NULL,
	Password	TEXT NOT NULL,
	Access	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY(UserId)
);
;
INSERT INTO Products () VALUES (1,'Intel Celeron G5905 OEM',3500.0);
INSERT INTO Products () VALUES (2,'AMD FX-4300 OEM',2876.2);
INSERT INTO Products () VALUES (3,'AMD Radeon R5 Entertainment Series [R532G1601U1S-U] ',600.0);
INSERT INTO Photos (PhotoId,ProductId,FileName) VALUES (3,1,'intel.webp');
INSERT INTO Photos (PhotoId,ProductId,FileName) VALUES (4,2,'amd.webp');
INSERT INTO Photos (PhotoId,ProductId,FileName) VALUES (5,3,'AMD Radeon R5 Entertainment Series_R532G1601U1S-U.webp');
INSERT INTO Users (UserId,UserName,Email,Password,Access) VALUES (1,'admin','123@gmail.com','sha256$l98Fq9Xnu52wGjQp$1b3d040c16c859ca987caace3c2df31481e31bce724befc29bdfa740f35b6384',77);
INSERT INTO Users (UserId,UserName,Email,Password,Access) VALUES (2,'maks','maks@gmail.com','sha256$l98Fq9Xnu52wGjQp$1b3d040c16c859ca987caace3c2df31481e31bce724befc29bdfa740f35b6384',1);
INSERT INTO Users (UserId,UserName,Email,Password,Access) VALUES (3,'demo','demo@gmail.com','sha256$mLMGg2j8nDNiecor$c107ad636a1e5c3e87eaed22f6a074fc636cfe123e84a533ffd9e8f89db380fa',1);
INSERT INTO Users (UserId,UserName,Email,Password,Access) VALUES (4,'qwer','qwer@gmail.com','sha256$NLTBmekHuYbhWRB3$43368043be1b6ee5f9f8c8e8af1a4090b8aeb339a54e827e6e5b28ecb85a5f25',1);
;
COMMIT;
