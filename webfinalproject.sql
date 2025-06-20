USE [master]
GO
/****** Object:  Database [RentalDB]    Script Date: 29-10-2024 21:49:05 ******/
CREATE DATABASE [RentalDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RentalDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2022EXPRESS\MSSQL\DATA\RentalDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RentalDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2022EXPRESS\MSSQL\DATA\RentalDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [RentalDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RentalDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RentalDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RentalDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RentalDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RentalDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RentalDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [RentalDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RentalDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RentalDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RentalDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RentalDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RentalDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RentalDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RentalDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RentalDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RentalDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RentalDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RentalDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RentalDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RentalDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RentalDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RentalDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RentalDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RentalDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RentalDB] SET  MULTI_USER 
GO
ALTER DATABASE [RentalDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RentalDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RentalDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RentalDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RentalDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RentalDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [RentalDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [RentalDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [RentalDB]
GO
/****** Object:  Table [dbo].[Apartments]    Script Date: 29-10-2024 21:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Apartments](
	[ApartmentID] [int] IDENTITY(1,1) NOT NULL,
	[PropertyID] [int] NULL,
	[UnitNumber] [nvarchar](10) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[RentAmount] [decimal](18, 2) NOT NULL,
	[NumberOfRooms] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ApartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 29-10-2024 21:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[TenantID] [int] NULL,
	[PropertyManagerID] [int] NULL,
	[ApartmentID] [int] NULL,
	[AppointmentDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 29-10-2024 21:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[SenderID] [int] NULL,
	[ReceiverID] [int] NULL,
	[MessageContent] [nvarchar](max) NOT NULL,
	[SentAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Properties]    Script Date: 29-10-2024 21:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[PropertyID] [int] IDENTITY(1,1) NOT NULL,
	[OwnerID] [int] NULL,
	[PropertyName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[ZipCode] [nvarchar](20) NULL,
	[CreatedAt] [datetime] NULL,
	[ManagerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentalAgreements]    Script Date: 29-10-2024 21:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalAgreements](
	[AgreementID] [int] IDENTITY(1,1) NOT NULL,
	[TenantID] [int] NULL,
	[ApartmentID] [int] NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[PaymentStatus] [nvarchar](50) NOT NULL,
	[MonthlyRent] [decimal](18, 2) NOT NULL,
	[DueDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AgreementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 29-10-2024 21:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](256) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Role] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Apartments] ON 

INSERT [dbo].[Apartments] ([ApartmentID], [PropertyID], [UnitNumber], [Status], [RentAmount], [NumberOfRooms], [CreatedAt]) VALUES (1, 1, N'101', N'Available', CAST(1500.00 AS Decimal(18, 2)), 3, CAST(N'2024-10-21T20:36:22.860' AS DateTime))
INSERT [dbo].[Apartments] ([ApartmentID], [PropertyID], [UnitNumber], [Status], [RentAmount], [NumberOfRooms], [CreatedAt]) VALUES (2, 1, N'102', N'Rented', CAST(1300.00 AS Decimal(18, 2)), 2, CAST(N'2024-10-21T20:36:22.860' AS DateTime))
INSERT [dbo].[Apartments] ([ApartmentID], [PropertyID], [UnitNumber], [Status], [RentAmount], [NumberOfRooms], [CreatedAt]) VALUES (3, 1, N'103', N'Available', CAST(1400.00 AS Decimal(18, 2)), 2, CAST(N'2024-10-21T20:36:22.860' AS DateTime))
INSERT [dbo].[Apartments] ([ApartmentID], [PropertyID], [UnitNumber], [Status], [RentAmount], [NumberOfRooms], [CreatedAt]) VALUES (4, 2, N'201', N'Available', CAST(1800.00 AS Decimal(18, 2)), 4, CAST(N'2024-10-21T20:36:22.860' AS DateTime))
INSERT [dbo].[Apartments] ([ApartmentID], [PropertyID], [UnitNumber], [Status], [RentAmount], [NumberOfRooms], [CreatedAt]) VALUES (5, 2, N'202', N'Rented', CAST(1700.00 AS Decimal(18, 2)), 3, CAST(N'2024-10-21T20:36:22.860' AS DateTime))
INSERT [dbo].[Apartments] ([ApartmentID], [PropertyID], [UnitNumber], [Status], [RentAmount], [NumberOfRooms], [CreatedAt]) VALUES (6, 2, N'203', N'Available', CAST(1600.00 AS Decimal(18, 2)), 2, CAST(N'2024-10-21T20:36:22.860' AS DateTime))
SET IDENTITY_INSERT [dbo].[Apartments] OFF
GO
SET IDENTITY_INSERT [dbo].[Properties] ON 

INSERT [dbo].[Properties] ([PropertyID], [OwnerID], [PropertyName], [Address], [City], [State], [ZipCode], [CreatedAt], [ManagerID]) VALUES (1, 1, N'Saints Heights', N'123 saint Street', N'Montreal', N'Quebec', N'H3Z 2Y7', CAST(N'2024-10-21T20:35:41.320' AS DateTime), NULL)
INSERT [dbo].[Properties] ([PropertyID], [OwnerID], [PropertyName], [Address], [City], [State], [ZipCode], [CreatedAt], [ManagerID]) VALUES (2, 2, N'Harry Villas', N'456 Harry Avenue', N'Toronto', N'Ontario', N'M5V 1E3', CAST(N'2024-10-21T20:35:41.320' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Properties] OFF
GO
SET IDENTITY_INSERT [dbo].[RentalAgreements] ON 

INSERT [dbo].[RentalAgreements] ([AgreementID], [TenantID], [ApartmentID], [StartDate], [EndDate], [PaymentStatus], [MonthlyRent], [DueDate]) VALUES (1, 5, 2, CAST(N'2024-01-01' AS Date), CAST(N'2025-01-01' AS Date), N'Paid', CAST(1300.00 AS Decimal(18, 2)), CAST(N'2024-11-01' AS Date))
INSERT [dbo].[RentalAgreements] ([AgreementID], [TenantID], [ApartmentID], [StartDate], [EndDate], [PaymentStatus], [MonthlyRent], [DueDate]) VALUES (2, 6, 5, CAST(N'2024-06-01' AS Date), CAST(N'2025-06-01' AS Date), N'Pending', CAST(1700.00 AS Decimal(18, 2)), CAST(N'2024-11-05' AS Date))
SET IDENTITY_INSERT [dbo].[RentalAgreements] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role], [Status], [CreatedAt]) VALUES (1, N'Aryan', N'aryan', N'Aryan Handa', N'aryanhanda@example.com', N'1234568790', N'PropertyOwner', N'Active', CAST(N'2024-10-21T20:34:46.700' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role], [Status], [CreatedAt]) VALUES (2, N'Naresh', N'naresh', N'Naresh Handa', N'nareshhanda@example.com', N'1234567891', N'PropertyOwner', N'Active', CAST(N'2024-10-21T20:34:46.700' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role], [Status], [CreatedAt]) VALUES (3, N'Dumbledore', N'dumbledore', N'Albus Dumbledore', N'albusdumbledore@example.com', N'1234567892', N'PropertyManager', N'Active', CAST(N'2024-10-21T20:34:46.703' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role], [Status], [CreatedAt]) VALUES (4, N'Sirius', N'sirius', N'Sirius Black', N'siriusblack@example.com', N'1234567893', N'PropertyManager', N'Active', CAST(N'2024-10-21T20:34:46.703' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role], [Status], [CreatedAt]) VALUES (5, N'Harry', N'harry', N'Harry Potter', N'Harry Potter@example.com', N'1234567894', N'Tenant', N'Active', CAST(N'2024-10-21T20:34:46.703' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [FullName], [Email], [PhoneNumber], [Role], [Status], [CreatedAt]) VALUES (6, N'Emma', N'emma', N'Emma Watson', N'emmawatson@example.com', N'1234567895', N'Tenant', N'Active', CAST(N'2024-10-21T20:34:46.703' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Apartments] ADD  DEFAULT ('Available') FOR [Status]
GO
ALTER TABLE [dbo].[Apartments] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT ('Scheduled') FOR [Status]
GO
ALTER TABLE [dbo].[Appointments] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Messages] ADD  DEFAULT (getdate()) FOR [SentAt]
GO
ALTER TABLE [dbo].[Properties] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[RentalAgreements] ADD  DEFAULT ('Pending') FOR [PaymentStatus]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Status]  DEFAULT ('Active') FOR [Status]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Apartments]  WITH CHECK ADD FOREIGN KEY([PropertyID])
REFERENCES [dbo].[Properties] ([PropertyID])
GO
ALTER TABLE [dbo].[Apartments]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_Property] FOREIGN KEY([PropertyID])
REFERENCES [dbo].[Properties] ([PropertyID])
GO
ALTER TABLE [dbo].[Apartments] CHECK CONSTRAINT [FK_Apartment_Property]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([ApartmentID])
REFERENCES [dbo].[Apartments] ([ApartmentID])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([PropertyManagerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD FOREIGN KEY([TenantID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([ReceiverID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD FOREIGN KEY([SenderID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Properties]  WITH CHECK ADD FOREIGN KEY([OwnerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RentalAgreements]  WITH CHECK ADD FOREIGN KEY([ApartmentID])
REFERENCES [dbo].[Apartments] ([ApartmentID])
GO
ALTER TABLE [dbo].[RentalAgreements]  WITH CHECK ADD FOREIGN KEY([TenantID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RentalAgreements]  WITH CHECK ADD  CONSTRAINT [FK_RentalAgreements_Apartment] FOREIGN KEY([ApartmentID])
REFERENCES [dbo].[Apartments] ([ApartmentID])
GO
ALTER TABLE [dbo].[RentalAgreements] CHECK CONSTRAINT [FK_RentalAgreements_Apartment]
GO
ALTER TABLE [dbo].[RentalAgreements]  WITH CHECK ADD  CONSTRAINT [FK_RentalAgreements_Tenant] FOREIGN KEY([TenantID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RentalAgreements] CHECK CONSTRAINT [FK_RentalAgreements_Tenant]
GO
USE [master]
GO
ALTER DATABASE [RentalDB] SET  READ_WRITE 
GO
