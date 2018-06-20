
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `USER`;
CREATE TABLE `USER` (
 		`id` varchar(32) NOT NULL,
		`user_name` varchar(64)  NULL COMMENT '用户姓名',
		`user_tel` varchar(64)  NULL COMMENT '用户电话',
		`user_sex` tinyint(1)  NULL COMMENT '用户性别',
		`login_name` varchar(64)  NULL COMMENT '登陆名',
		`passwrod` varchar(64)  NULL COMMENT '密码',
		`user_img` text(0)  NULL COMMENT '用户头像',
		`org_code` varchar(64)  NULL COMMENT '机构代码',
		`open_id` varchar(64)  NULL COMMENT 'wx openId',
		`create_user`  varchar(64) NULL COMMENT '创建用户' ,
		`create_date`  datetime NULL COMMENT '创建时间' ,
		`update_user`  varchar(64) NULL COMMENT '更新用户' ,
		`update_date`  datetime NULL COMMENT '更新时间' ,
  		PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ORG`;
CREATE TABLE `ORG` (
 		`id` varchar(32) NOT NULL,
		`p_id` varchar(64)  NULL COMMENT '上级机构id',
		`org_name` varchar(64)  NULL COMMENT '机构名称',
		`create_user`  varchar(64) NULL COMMENT '创建用户' ,
		`create_date`  datetime NULL COMMENT '创建时间' ,
		`update_user`  varchar(64) NULL COMMENT '更新用户' ,
		`update_date`  datetime NULL COMMENT '更新时间' ,
  		PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `PERMISSION`;
CREATE TABLE `PERMISSION` (
 		`id` varchar(32) NOT NULL,
		`p_id` varchar(64)  NULL COMMENT '上级id',
		`p_name` varchar(64)  NULL COMMENT '权限名称',
		`create_user`  varchar(64) NULL COMMENT '创建用户' ,
		`create_date`  datetime NULL COMMENT '创建时间' ,
		`update_user`  varchar(64) NULL COMMENT '更新用户' ,
		`update_date`  datetime NULL COMMENT '更新时间' ,
  		PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `TARGET_INFO`;
CREATE TABLE `TARGET_INFO` (
 		`id` varchar(32) NOT NULL,
		`user_id` varchar(64)  NULL COMMENT '用户id',
		`message` varchar(200)  NULL COMMENT '目标说明',
		`start_time` datetime  NULL COMMENT '开始时间',
		`end_time` datetime  NULL COMMENT '结束时间',
		`rate_progress` tinyint(1)  NULL COMMENT '目标进度',
		`status` tinyint(1) DEFAULT '1' NOT NULL COMMENT '目标状态',
		`create_user`  varchar(64) NULL COMMENT '创建用户' ,
		`create_date`  datetime NULL COMMENT '创建时间' ,
		`update_user`  varchar(64) NULL COMMENT '更新用户' ,
		`update_date`  datetime NULL COMMENT '更新时间' ,
  		PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `PUNCH_CLOCK`;
CREATE TABLE `PUNCH_CLOCK` (
 		`id` varchar(100) NOT NULL,
		`user_id` varchar(64)  NULL COMMENT '用户id',
		`org_id` varchar(64)  NULL COMMENT '机构id',
		`punch_info` varchar(200)  NULL COMMENT '打卡信息',
		`img_base` text(0)  NULL COMMENT '图片信息',
		`time_info` varchar(64)  NULL COMMENT '打卡时间',
		`is_leave` varchar(1) DEFAULT '0' COMMENT '是否请假',
		`create_user`  varchar(64) NULL COMMENT '创建用户' ,
		`create_date`  datetime NULL COMMENT '创建时间' ,
		`update_user`  varchar(64) NULL COMMENT '更新用户' ,
		`update_date`  datetime NULL COMMENT '更新时间' ,
  		PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
