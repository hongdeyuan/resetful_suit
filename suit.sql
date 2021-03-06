USE [suit]
GO
/****** Object:  Table [dbo].[T_UserModel]    Script Date: 12/17/2018 17:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_UserModel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[model_code] [nvarchar](50) NOT NULL,
	[model_path] [nvarchar](50) NOT NULL,
	[model_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_T_Model_1] PRIMARY KEY CLUSTERED 
(
	[model_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[T_UserModel] ON
INSERT [dbo].[T_UserModel] ([id], [model_code], [model_path], [model_name]) VALUES (1, N'01', N'models/male/male01/', N'male01')
INSERT [dbo].[T_UserModel] ([id], [model_code], [model_path], [model_name]) VALUES (2, N'02', N'models/female/female01/', N'female01')
SET IDENTITY_INSERT [dbo].[T_UserModel] OFF
/****** Object:  Table [dbo].[T_User]    Script Date: 12/17/2018 17:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account] [nvarchar](50) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[permission] [bit] NOT NULL,
	[sex] [bit] NOT NULL,
	[profile_photo] [nvarchar](50) NOT NULL,
	[model_code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_T_user] PRIMARY KEY CLUSTERED 
(
	[account] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[T_User] ON
INSERT [dbo].[T_User] ([id], [account], [username], [password], [permission], [sex], [profile_photo], [model_code]) VALUES (3, N'normal', N'普通用户', N'123456', 0, 0, N'images/data/model/wheadB.png', N'02')
INSERT [dbo].[T_User] ([id], [account], [username], [password], [permission], [sex], [profile_photo], [model_code]) VALUES (2, N'super', N'管理员', N'123456', 1, 0, N'images/data/model/wheadA.png', N'02')
SET IDENTITY_INSERT [dbo].[T_User] OFF
/****** Object:  Table [dbo].[T_Dress]    Script Date: 12/17/2018 17:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Dress](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account] [nvarchar](50) NOT NULL,
	[clothes_code] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_T_Dress] PRIMARY KEY CLUSTERED 
(
	[account] ASC,
	[clothes_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[T_Dress] ON
INSERT [dbo].[T_Dress] ([id], [account], [clothes_code]) VALUES (57, N'super', N'f_hair04')
INSERT [dbo].[T_Dress] ([id], [account], [clothes_code]) VALUES (56, N'super', N'f_shoes01')
INSERT [dbo].[T_Dress] ([id], [account], [clothes_code]) VALUES (45, N'super', N'f_trousers02')
SET IDENTITY_INSERT [dbo].[T_Dress] OFF
/****** Object:  Table [dbo].[T_Clothes]    Script Date: 12/17/2018 17:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_Clothes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[clothes_code] [nvarchar](50) NOT NULL,
	[clothes_name] [nvarchar](50) NOT NULL,
	[category_code] [nvarchar](50) NOT NULL,
	[price] [float] NOT NULL,
	[clothes_path] [nvarchar](50) NULL,
	[clothes_sex] [bit] NOT NULL,
	[clothesobj_path] [varchar](50) NULL,
 CONSTRAINT [PK_T_Clothes] PRIMARY KEY CLUSTERED 
(
	[clothes_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[T_Clothes] ON
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (7, N'f_clothes01', N'女衣1', N'clothes', 160, N'images/data/suits/hair/f_hair04.png', 0, N'suits/female/clothes/clothes01/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (1, N'f_hair01', N'头发1', N'hair', 60, N'images/data/suits/hair/f_hair01.png', 0, N'suits/female/hair/hair01/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (3, N'f_hair02', N'头发2', N'hair', 77, N'images/data/suits/hair/f_hair02.png', 0, N'suits/female/hair/hair02/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (4, N'f_hair03', N'头发3', N'hair', 66, N'images/data/suits/hair/f_hair03.png', 0, N'suits/female/hair/hair03/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (5, N'f_hair04', N'头发4', N'hair', 59, N'images/data/suits/hair/f_hair04.png', 0, N'suits/female/hair/hair04/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (10, N'f_shoes01', N'鞋子1', N'shoes', 260, N'images/data/suits/shoes/f_shoes01.png', 0, N'suits/female/shoes/shoes01/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (12, N'f_shoes02', N'鞋子2', N'shoes', 280, N'images/data/suits/shoes/f_shoes02.png', 0, N'suits/female/shoes/shoes02/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (13, N'f_shoes03', N'鞋子3', N'shoes', 290, N'images/data/suits/shoes/f_shoes03.png', 0, N'suits/female/shoes/shoes03/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (14, N'f_shoes04', N'鞋子4', N'shoes', 300, N'images/data/suits/shoes/f_shoes04.png', 0, N'suits/female/shoes/shoes04/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (9, N'f_trousers01', N'裤子1', N'trousers', 140, N'images/data/suits/trousers/f_trousers01.png', 0, N'suits/female/trousers/trousers01/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (15, N'f_trousers02', N'裤子2', N'trousers', 160, N'images/data/suits/trousers/f_trousers02.png', 0, N'suits/female/trousers/trousers02/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (16, N'f_trousers03', N'裤子3', N'trousers', 140, N'images/data/suits/trousers/f_trousers03.png', 0, N'suits/female/trousers/trousers03/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (17, N'f_trousers04', N'裤子4', N'trousers', 120, N'images/data/suits/trousers/f_trousers04.png', 0, N'suits/female/trousers/trousers04/')
INSERT [dbo].[T_Clothes] ([id], [clothes_code], [clothes_name], [category_code], [price], [clothes_path], [clothes_sex], [clothesobj_path]) VALUES (18, N'f_trousers05', N'裤子5', N'trousers', 260, N'images/data/suits/trousers/f_trousers05.png', 0, N'suits/female/trousers/trousers05/')
SET IDENTITY_INSERT [dbo].[T_Clothes] OFF
/****** Object:  Table [dbo].[T_Category]    Script Date: 12/17/2018 17:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category_code] [nvarchar](50) NOT NULL,
	[category_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_T_Category] PRIMARY KEY CLUSTERED 
(
	[category_code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[T_Category] ON
INSERT [dbo].[T_Category] ([id], [category_code], [category_name]) VALUES (11, N'clothes', N'衣服')
INSERT [dbo].[T_Category] ([id], [category_code], [category_name]) VALUES (10, N'hair', N'头发')
INSERT [dbo].[T_Category] ([id], [category_code], [category_name]) VALUES (13, N'shoes', N'鞋子')
INSERT [dbo].[T_Category] ([id], [category_code], [category_name]) VALUES (12, N'trousers', N'裤子')
SET IDENTITY_INSERT [dbo].[T_Category] OFF
/****** Object:  View [dbo].[V_DressView]    Script Date: 12/17/2018 17:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DressView]
AS
SELECT     dbo.T_Dress.id, dbo.T_Dress.account, dbo.T_Clothes.clothes_code, dbo.T_Clothes.clothes_path, dbo.T_Clothes.clothesobj_path, dbo.T_Clothes.clothes_sex, dbo.T_Clothes.price, 
                      dbo.T_Clothes.clothes_name, dbo.T_Clothes.category_code
FROM         dbo.T_Clothes INNER JOIN
                      dbo.T_Dress ON dbo.T_Clothes.clothes_code = dbo.T_Dress.clothes_code
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T_Clothes"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 199
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "T_Dress"
            Begin Extent = 
               Top = 6
               Left = 237
               Bottom = 126
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DressView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_DressView'
GO
/****** Object:  Default [DF_T_Clothes_price]    Script Date: 12/17/2018 17:54:07 ******/
ALTER TABLE [dbo].[T_Clothes] ADD  CONSTRAINT [DF_T_Clothes_price]  DEFAULT ((0.0)) FOR [price]
GO
