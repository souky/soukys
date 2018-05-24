/*
 Navicat Premium Data Transfer

 Source Server         : 51
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : 192.168.1.51:3306
 Source Schema         : shield-system

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 18/05/2018 10:24:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for jy_classroom_info_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_classroom_info_tab`;
CREATE TABLE `jy_classroom_info_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `building_names` varchar(255)  NULL DEFAULT NULL COMMENT '楼的名称集合 name1;name2;name3',
  `building_no` tinyint(2) NULL DEFAULT NULL COMMENT '楼的数量',
  `floor_no` tinyint(2) NULL DEFAULT NULL COMMENT '每个楼的楼层数量',
  `classroom_no` tinyint(2) NULL DEFAULT NULL COMMENT '每层教室数量',
  `create_user` varchar(32)  NULL DEFAULT NULL,
  `create_date` timestamp(0) NULL DEFAULT NULL,
  `update_user` varchar(32)  NULL DEFAULT NULL,
  `update_date` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_classroom_info_tab
-- ----------------------------
INSERT INTO `jy_classroom_info_tab` VALUES ('f976b87c1e6040fd8bde25c8486ae4d1', '教学楼1;教学楼2;教学楼3', 3, 3, 3, '1', '2018-04-23 12:34:01', NULL, '2018-05-17 10:10:38');

-- ----------------------------
-- Table structure for jy_device_group_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_device_group_tab`;
CREATE TABLE `jy_device_group_tab`  (
  `id` varchar(32)  NOT NULL,
  `group_name` varchar(50)  NOT NULL COMMENT '设备分组名称',
  `group_no` int(2) NOT NULL COMMENT '分组编号',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `control_module` tinyint(1) NOT NULL DEFAULT 0 COMMENT '控制模块 (0:全部,1:1g,2:手机)',
  `is_active` tinyint(1) NULL DEFAULT 1 COMMENT '是否激活(1:激活,0:禁用)',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构id',
  `create_user` varchar(32)  NULL DEFAULT NULL,
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '	日期',
  `update_user` varchar(32)  NULL DEFAULT NULL,
  `update_date` timestamp(0) NULL DEFAULT NULL,
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Table structure for jy_device_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_device_tab`;
CREATE TABLE `jy_device_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32uuid',
  `ip` varchar(15)  NOT NULL COMMENT '设备的ip地址',
  `mac` varchar(17)  NOT NULL COMMENT 'mac地址',
  `sn` varchar(25)  NULL DEFAULT NULL COMMENT '设备编码',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型  0：未知、1：侦测、2：阻断',
  `address` varchar(255)  NULL DEFAULT NULL COMMENT '设备放置地点',
  `version` varchar(20)  NULL DEFAULT NULL COMMENT '版本号',
  `status` tinyint(1) NULL DEFAULT 2 COMMENT '状态  1：在线、2：离线',
  `poweroff` tinyint(1) NULL DEFAULT 2 COMMENT '开关机 1:开机, 2:关机',
  `list_order` int(3) NULL DEFAULT NULL COMMENT '设备对应教室编排顺序',
  `work_status` tinyint(1) NULL DEFAULT NULL COMMENT '工作状态 	0：未知、1：无考试计划、2：考中、3：考间、4：空闲',
  `controlled` varchar(20)  NULL DEFAULT NULL COMMENT '受控状态 	0：未知、1：自动、2：手动',
  `operation_type` varchar(20)  NULL DEFAULT NULL,
  `group_no` tinyint(2) NULL DEFAULT NULL COMMENT '分组no [0,99]',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构32位UUID',
  `create_user` varchar(32)  NULL DEFAULT NULL COMMENT '有且仅是侦测和阻断32位UUID',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '	日期',
  `update_user` varchar(32)  NULL DEFAULT NULL COMMENT '有且仅是侦测和阻断32位UUID',
  `update_date` timestamp(0) NULL DEFAULT NULL,
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `vender` varchar(10)  NULL DEFAULT NULL COMMENT '设备厂家',
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `unique_ip`(`ip`)  COMMENT 'ip唯一'
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_device_tab
-- ----------------------------
INSERT INTO `jy_device_tab` VALUES ('8d90735cd69f47fb9c7e26eb4a65294e', '192.168.1.167', '9C431EC00035', 'JY-ZDSB-20180505-001', 2, '测试位置', 'JY_JS_100', 1, 2, 0, NULL, NULL, '0', NULL, '0fae7da3605b4bd687f1f97be25e289e', '1', '2018-05-18 10:01:22', NULL, '2018-05-18 10:24:12', NULL, 'JY');

-- ----------------------------
-- Table structure for jy_exam_after_data_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_exam_after_data_tab`;
CREATE TABLE `jy_exam_after_data_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `file_name` varchar(100)  NULL DEFAULT NULL COMMENT '文件名称',
  `exam_plan_id` varchar(32)  NULL DEFAULT NULL COMMENT '考试计划id',
  `exam_number_id` varchar(32)  NULL DEFAULT NULL COMMENT '考试场次id',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp(0) NULL DEFAULT NULL COMMENT '结束时间',
  `file_numbers` int(11) NULL DEFAULT NULL COMMENT '打包的文件个数',
  `file_size` bigint(20) NULL DEFAULT NULL COMMENT '文件大小',
  `file_address` varchar(255)  NULL DEFAULT NULL COMMENT '文件地址',
  `file_byte` longblob NULL COMMENT '文件二进制字节流',
  `file_type` varchar(255)  NULL DEFAULT NULL COMMENT '文件后缀',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构id',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Table structure for jy_exam_plan_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_exam_plan_tab`;
CREATE TABLE `jy_exam_plan_tab`  (
  `id` varchar(32)  NOT NULL,
  `exam_name` varchar(50)  NOT NULL COMMENT '考试名称',
  `exam_no` varchar(100)  NOT NULL COMMENT '考试序号   年份+自动序号',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp(0) NULL DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT 2 COMMENT '类型:1启用,2禁用',
  `exam_type_id` varchar(32)  NOT NULL COMMENT '考试类型id',
  `org_id` varchar(32)  NOT NULL COMMENT '组织机构id',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;


-- ----------------------------
-- Table structure for jy_exam_sub_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_exam_sub_tab`;
CREATE TABLE `jy_exam_sub_tab`  (
  `id` varchar(32)  NOT NULL,
  `no` int(5) NOT NULL COMMENT '场次序号',
  `name` varchar(100)  NOT NULL COMMENT '场次名称',
  `start_time` timestamp(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp(0) NULL DEFAULT NULL COMMENT '结束时间',
  `exam_plan_id` varchar(32)  NOT NULL COMMENT '考试计划id',
  `org_id` varchar(32)  NOT NULL COMMENT '组织机构id',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Table structure for jy_exam_type_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_exam_type_tab`;
CREATE TABLE `jy_exam_type_tab`  (
  `id` varchar(32)  NOT NULL,
  `exam_type_no` bigint(20) NULL DEFAULT NULL COMMENT '考试类型序号',
  `exam_type_name` varchar(255)  NULL DEFAULT NULL COMMENT '考试类型名称',
  `org_id` varchar(32)  NOT NULL COMMENT '组织机构id',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_exam_type_tab
-- ----------------------------
INSERT INTO `jy_exam_type_tab` VALUES ('56008694b1fb4699931ced37845dff21', 1, '高考', '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-02 14:30:56', '1', '2018-05-02 14:30:56', NULL);

-- ----------------------------
-- Table structure for jy_menu_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_menu_tab`;
CREATE TABLE `jy_menu_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `bsid` varchar(29)  NULL DEFAULT NULL,
  `menu_name` varchar(100)  NULL DEFAULT NULL COMMENT '菜单名称',
  `menu_order` tinyint(1) NULL DEFAULT NULL COMMENT '菜单顺序',
  `permission_id` varchar(32)  NULL DEFAULT NULL COMMENT '权限ID',
  `menu_level` tinyint(1) UNSIGNED NOT NULL COMMENT '菜单等级',
  `url` varchar(100)  NULL DEFAULT NULL COMMENT '菜单跳转的URL',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_menu_tab
-- ----------------------------
INSERT INTO `jy_menu_tab` VALUES ('1293c5e6d1244c248b1635c9a98be564', '00003-00002-00000-00000-00000', '实时监听', 3, 'bd14756e3239436a8c6b1e9ef3c09698', 2, 'suspiciousSignal/monitor', '', 1, 'wb', '2017-10-27 13:58:18', '1', '2017-10-27 13:58:18');
INSERT INTO `jy_menu_tab` VALUES ('202d69dfbf2a4e75981c0947e57fabd5', '00003-00001-00000-00000-00000', '可疑信号', 1, 'e2fc12d882de4072a830dbed8edbccff', 2, 'suspiciousSignal/suspicious_signal_list', '', 1, 'wb', '2017-10-27 13:55:48', '1', '2017-12-13 10:13:06');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d144', '00008-00000-00000-00000-00000', '个人信息', 6, '4aad35f1de154de281df3f916875d119', 1, '', 'info', 1, '1', '2017-10-27 13:52:08', '1', '2018-02-28 09:46:28');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d166', '00009-00003-00000-00000-00000', '用户管理', 3, '4aad35f1de154de281df3f916875d118', 2, '/user/user_list', '', 0, 'wb', '2017-10-27 13:58:40', '1', '2018-05-18 09:46:57');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d1d1', '00009-00000-00000-00000-00000', '系统设置', 7, '4aad35f1de154de281df3f916875d113', 1, '', 'system', 0, '1', '2017-10-27 13:52:30', '1', '2018-05-18 09:47:02');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d1d2', '00008-00001-00000-00000-00000', '个人信息', 1, '4aad35f1de154de281df3f916875d114', 2, '/user/userEdit', '用户管理', 1, '1', '2017-10-27 13:58:34', '1', '2018-02-28 09:46:34');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d1d3', '00008-00002-00000-00000-00000', '密码管理', 2, '4aad35f1de154de281df3f916875d115', 2, '/user/editPassword', '密码管理', 1, '1', '2017-10-27 13:58:35', '1', '2018-02-28 09:46:35');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d1d4', '00009-00001-00000-00000-00000', '角色信息', 1, '4aad35f1de154de281df3f916875d116', 2, '/role/role_list', NULL, 1, '1', '2017-10-27 13:58:38', '1', '2018-02-28 09:46:37');
INSERT INTO `jy_menu_tab` VALUES ('4aad35f1de154de281df3f916875d1d5', '00009-00002-00000-00000-00000', '组织机构', 2, '4aad35f1de154de281df3f916875d117', 2, '/org/org_list', '', 1, '1', '2017-10-27 13:58:39', '1', '2018-02-28 09:46:39');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a00', '00000-00002-00000-00000-00000', '设备分组', 2, '9dbf0e94ccdb44d7a2e5c434e8b8b122', 2, 'device/deviceGroup', '', 1, 'wb', '2017-11-13 09:40:36', '1', '2018-02-28 09:46:41');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a10', '00000-00000-00000-00000-00000', '设备管理', 0, '9dbf0e94ccdb44d7a2e5c434e8b8b120', 1, NULL, 'device', 1, '1', '2017-10-27 13:57:55', '1', '2018-02-28 09:46:43');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a11', '00000-00001-00000-00000-00000', '设备展示', 1, '9dbf0e94ccdb44d7a2e5c434e8b8b121', 2, 'device/device', '', 1, '1', '2017-10-27 13:55:45', '1', '2018-02-28 09:46:45');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a12', '00001-00000-00000-00000-00000', '考试管理', 1, '9dbf0e94ccdb44d7a2e5c434e8b8b123', 1, '', 'exam', 0, '1', '2017-10-27 13:57:57', '1', '2018-03-26 09:56:39');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a13', '00001-00001-00000-00000-00000', '考试计划', 2, '8a1edc19adc94f99852912cbf06d71a1', 2, 'exam/examList', '', 0, '1', '2017-10-27 13:57:58', '1', '2018-03-26 09:56:42');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a14', '00001-00002-00000-00000-00000', '考试类型', 1, 'bab83e402b004ef2bd6f57428ce3d84d', 2, 'exam/examTypeList', '', 0, '1', '2017-10-27 13:57:59', '1', '2018-03-26 09:56:45');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a15', '00002-00000-00000-00000-00000', '黑白名单', 2, '9dbf0e94ccdb44d7a2e5c434e820b120', 1, '', 'blacklist', 1, '1', '2017-10-27 13:58:11', '1', '2018-02-28 09:46:52');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a16', '00002-00001-00000-00000-00000', '黑白名单', 1, '9dbf0e94ccdb44d7a2e5c434e821b121', 2, 'blackwhitelist/blackwhitelist', '测试用', 1, '1', '2017-10-27 13:58:13', '1', '2018-02-28 09:46:53');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a17', '00003-00003-00000-00000-00000', '还原信号', 3, '6cc537968d6a42469266b78889b40919', 2, 'exam/reductionInfo', '', 1, '1', '2017-10-27 13:51:40', '1', '2018-02-28 09:46:58');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a18', '00004-00000-00000-00000-00000', '统计分析', 4, '9dbf0e94ccdb44d7a2e5c434e822b120', 1, '', 'statistics', 1, '1', '2017-10-27 13:58:23', '1', '2018-02-28 09:47:00');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a19', '00004-00001-00000-00000-00000', '统计数据', 1, '9dbf0e94ccdb44d7a2e5c434e823b121', 2, 'statistics/statisticsAnalysis', '测试用', 1, '1', '2017-10-27 13:58:28', '1', '2018-02-28 09:47:01');
INSERT INTO `jy_menu_tab` VALUES ('aert55ba8f0245f3957b493943476a89', '00001-00003-00000-00000-00000', '考后数据整理', 3, 'bab83e402b004ef2bd6f57428ce3d000', 2, 'exam/packageInfo', '', 1, '1', '2017-10-27 13:58:05', '1', '2018-02-28 09:47:02');
INSERT INTO `jy_menu_tab` VALUES ('e5bb21e26c8d47fa97e8a55e113a5978', '00009-00004-00000-00000-00000', '查看日志', 4, '4aad35f1de154de281df3f916875d120', 2, 'log/showLog', '', 0, 'sjn', '2017-10-27 13:58:41', '1', '2018-05-18 09:47:11');
INSERT INTO `jy_menu_tab` VALUES ('e5bb21e26c8d47fa97e8a55e113a5991', '00003-00000-00000-00000-00000', '还原信号', 3, 'a21aa9b21b244350865bdae31f06d4c7', 1, '', 'single', 1, 'wb', '2017-10-27 13:55:46', '1', '2018-02-28 09:47:09');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a5966', '00011-00000-00000-00000-00000', '屏蔽终端', 9, NULL, 1, NULL, 'shield', 0, 'wb', '2018-01-03 14:15:05', NULL, '2018-01-03 14:24:23');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a5967', '00011-00001-00000-00000-00000', '屏蔽终端列表', 1, NULL, 2, 'shield/shieldList', NULL, 0, 'wb', '2018-01-03 14:15:05', NULL, '2018-03-30 10:32:45');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a5969', '00011-00001-00000-00000-00000', '屏蔽终端分布', 1, NULL, 2, 'shield/shieldDistribution', NULL, 0, 'wb', '2018-01-03 14:15:05', NULL, '2018-01-03 14:55:26');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a5990', '00010-00000-00000-00000-00000', '通信检测', 8, '4aad35f1de154de281df3f916875d121', 1, '', 'systemCheck', 1, 'xp', '2017-10-27 14:20:10', '1', '2018-02-28 09:47:15');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a5991', '00010-00001-00000-00000-00000', '系统检测', 2, '4aad35f1de154de281df3f916875d122', 2, 'systemCheck/systemCheck', NULL, 1, 'xp', '2017-10-27 13:57:13', '1', '2018-02-28 09:47:18');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a5992', '00010-00002-00000-00000-00000', '参数配置', 1, '4aad35f1de154de281df3f916875d123', 2, 'systemCheck/paramConfig', '', 1, 'xp', '2017-10-30 10:24:58', '1', '2018-02-28 09:47:21');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a59ab', '00012-00000-00000-00000-00000', '电子时钟', 9, NULL, 1, NULL, 'shield', 1, 'wb', '2018-01-03 14:15:05', NULL, '2018-03-23 16:59:55');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a59ap', '00012-00003-00000-00000-00000', '电子时钟卫星分布', 9, NULL, 2, 'clock/clock_satellite', 'shield', 1, 'wb', '2018-01-03 14:15:05', NULL, '2018-03-23 16:59:56');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a59as', '00012-00002-00000-00000-00000', '电子时钟分布', 9, NULL, 2, 'clock/clock_distribute', 'shield', 1, 'wb', '2018-01-03 14:15:05', NULL, '2018-03-23 16:59:59');
INSERT INTO `jy_menu_tab` VALUES ('q2xx21e26c8d47fa97e8a55e113a59av', '00012-00001-00000-00000-00000', '电子时钟列表', 9, NULL, 2, 'clock/clock_list', 'shield', 1, 'wb', '2018-01-03 14:15:05', NULL, '2018-03-23 17:00:02');

-- ----------------------------
-- Table structure for jy_open_close_plan_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_open_close_plan_tab`;
CREATE TABLE `jy_open_close_plan_tab`  (
  `id` varchar(32)  NOT NULL,
  `group_no` tinyint(2) NOT NULL COMMENT '分组',
  `start_time` datetime(0) NOT NULL COMMENT '开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '结束时间',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构32位UUID',
  `create_user` varchar(32)  NULL DEFAULT NULL COMMENT '有且仅是侦测和阻断32位UUID',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '	日期',
  `update_user` varchar(32)  NULL DEFAULT NULL COMMENT '有且仅是侦测和阻断32位UUID',
  `update_date` timestamp(0) NULL DEFAULT NULL,
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Table structure for jy_organization_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_organization_tab`;
CREATE TABLE `jy_organization_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `bsid` varchar(29)  NULL DEFAULT NULL,
  `ip` varchar(15)  NULL DEFAULT NULL COMMENT 'ip',
  `code` varchar(10)  NULL DEFAULT NULL COMMENT '机构所属地区CODE',
  `parent_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构父ID',
  `name` varchar(100)  NULL DEFAULT NULL COMMENT '组织机构名称',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_organization_tab
-- ----------------------------
INSERT INTO `jy_organization_tab` VALUES ('01a987fae1124c7080e4bb7bdcacc639', NULL, NULL, '320381', '6071f9a7cdc045ceb98f46eced31f2a2', '新沂市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('04cf123a5dcd44039fd1b5e7a29f9543', NULL, NULL, '320281', 'cb7fdf26ffc346d08cb29a983aca0d56', '江阴市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('0b63cca374da450d9f3b03d6918f3278', NULL, NULL, '320804', '2043be5fb5074621be5498ee53650319', '淮阴区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('0ed2a0304e8c41c4a28fa8bb6523208b', NULL, NULL, '320921', 'e93fd00029244f4a9fe859672a9bffc3', '响水县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('0fae7da3605b4bd687f1f97be25e289e', '00000-00000-00000-00000-测试', '192.168.128.231', NULL, 'b697fb96302248389e7c5af2860ad49a', '苏州大学', '', 0, '4b9834a5c5814e74a58b71070ac3af47', '2017-12-04 10:43:55', '4b9834a5c5814e74a58b71070ac3af47', '2018-03-15 14:41:48');
INSERT INTO `jy_organization_tab` VALUES ('1351dc358a654f2090d6d194e9cdabf3', NULL, NULL, '321012', '4da7414059ac483ea31ffc60bbcc9577', '江都区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('1655a39f8f894fc4ab887beb2778092f', NULL, NULL, '320507', 'e68cc44a4d2447f98fc4239919750efc', '相城区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('17a7c6abc7114b9793d4248afdd19e03', NULL, NULL, '320104', '3a93a5d4e2b2499399461af9aaef7d88', '秦淮区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('1deecb8e98f2487b91405d9830c67df5', NULL, NULL, '320611', '476e8eb50a1e4371aa3960c7c270b906', '港闸区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('1fe7d14614084fb28830b6cdde809bd3', NULL, NULL, '321102', 'ec58bde427fa475b8b5eaca4501f36b7', '京口区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('2043be5fb5074621be5498ee53650319', NULL, NULL, '320800', 'b3850546997b43c1a8960276bb06b720', '淮安市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('20647a5e2f024e69890de2b8ba0fb2f6', NULL, NULL, '321282', 'a62b36b6761c43cbb41cd9bd74ff8b24', '靖江市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('2118e05234d24308883527f4db9451c8', NULL, NULL, '321283', 'a62b36b6761c43cbb41cd9bd74ff8b24', '泰兴市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('23c4b9e3b56e437a8841810d2e8544fd', NULL, NULL, '320700', 'b3850546997b43c1a8960276bb06b720', '连云港市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('274533e3f269449ba721fb79685cb82c', NULL, NULL, '320117', '3a93a5d4e2b2499399461af9aaef7d88', '溧水区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('27729e14a9284b8280bdeea6b3aab4b1', NULL, NULL, '320211', 'cb7fdf26ffc346d08cb29a983aca0d56', '滨湖区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('294a2295d1e944658c1379f3fcbe5440', NULL, NULL, '320322', '6071f9a7cdc045ceb98f46eced31f2a2', '沛县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('29d403ceea3a41329b68df8cb750d483', NULL, NULL, '320508', 'e68cc44a4d2447f98fc4239919750efc', '姑苏区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('2ae0d65d57fa4b7bb2195e9f6c9eec9d', NULL, NULL, '320602', '476e8eb50a1e4371aa3960c7c270b906', '崇川区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('2c0fbd7bb2164c00a8347b81302d8f9e', NULL, NULL, '321084', '4da7414059ac483ea31ffc60bbcc9577', '高邮市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('2c7d6e2c5c2b47588e7c7dd996fd5deb', NULL, NULL, '321081', '4da7414059ac483ea31ffc60bbcc9577', '仪征市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('32fe8be27df0451d929dd44984a56a6e', NULL, NULL, '321202', 'a62b36b6761c43cbb41cd9bd74ff8b24', '海陵区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('3a93a5d4e2b2499399461af9aaef7d88', NULL, NULL, '320100', 'b3850546997b43c1a8960276bb06b720', '南京市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('3b0da17ae43e4ba09807721c6ea7674f', NULL, NULL, '321324', 'db14d49652e247e4af24140358e1e288', '泗洪县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('3b21ced4c2324a9b9990de4740291a60', NULL, NULL, '321023', '4da7414059ac483ea31ffc60bbcc9577', '宝应县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('3d7672ebb9814c59affc1024ba27f826', NULL, NULL, '320582', 'e68cc44a4d2447f98fc4239919750efc', '张家港市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('3d7d89dfdd4a49d9899a8b34fa1634a6', NULL, NULL, '320404', 'fa3ea4e1ca29480cb98e02bce38eb823', '钟楼区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('3ea9a9f4e53b4cf6bc5453ea121d6013', NULL, NULL, '320324', '6071f9a7cdc045ceb98f46eced31f2a2', '睢宁县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('40df82643ed041d8bef5d9ac68a6d72a', NULL, NULL, '320115', '3a93a5d4e2b2499399461af9aaef7d88', '江宁区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('459053adb674451aa037ea8a24536287', NULL, NULL, '320924', 'e93fd00029244f4a9fe859672a9bffc3', '射阳县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('45d1c64deadf40bc96deca47dcd919bc', NULL, NULL, '320707', '23c4b9e3b56e437a8841810d2e8544fd', '赣榆区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('46cbf4529912449c94a1bbe5d631dd58', NULL, NULL, '320105', '3a93a5d4e2b2499399461af9aaef7d88', '建邺区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('476e8eb50a1e4371aa3960c7c270b906', NULL, NULL, '320600', 'b3850546997b43c1a8960276bb06b720', '南通市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('48acd9ea7fbd4875ba9d91607ec9914e', NULL, NULL, '320612', '476e8eb50a1e4371aa3960c7c270b906', '通州区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('4afe9ceeed83430287faf4a2aa58a62e', NULL, NULL, '320922', 'e93fd00029244f4a9fe859672a9bffc3', '滨海县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('4da7414059ac483ea31ffc60bbcc9577', NULL, NULL, '321000', 'b3850546997b43c1a8960276bb06b720', '扬州市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('5173fadfd7cd48ef9a3ee8b43d5facfd', NULL, NULL, '320311', '6071f9a7cdc045ceb98f46eced31f2a2', '泉山区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('522dd67e441d47c8b0bd96be39face85', NULL, NULL, '320902', 'e93fd00029244f4a9fe859672a9bffc3', '亭湖区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('538e2a9dca714a2c957c8160ed074517', NULL, NULL, '320303', '6071f9a7cdc045ceb98f46eced31f2a2', '云龙区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('58072ab7caa54dcbaacb73e2ea60dad3', NULL, NULL, '320321', '6071f9a7cdc045ceb98f46eced31f2a2', '丰县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('5b12d2c67a5540d193ece8bfac20514f', NULL, NULL, '320803', '2043be5fb5074621be5498ee53650319', '淮安区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('5ba0a42d4d7c44b29741ce8fbf8b7771', NULL, NULL, '321302', 'db14d49652e247e4af24140358e1e288', '宿城区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('5e99a5a1e9eb4596963cc66fb6d3c793', NULL, NULL, '320312', '6071f9a7cdc045ceb98f46eced31f2a2', '铜山区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('6071f9a7cdc045ceb98f46eced31f2a2', NULL, NULL, '320300', 'b3850546997b43c1a8960276bb06b720', '徐州市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('61542768a03f44a381273f5a54ffc8dc', NULL, NULL, '320412', 'fa3ea4e1ca29480cb98e02bce38eb823', '武进区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('661a4ccce6944ae5a03582742f1c32b6', NULL, NULL, '320382', '6071f9a7cdc045ceb98f46eced31f2a2', '邳州市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('66ce6caf2efe412b9f086ffec0c983b8', NULL, NULL, '320684', '476e8eb50a1e4371aa3960c7c270b906', '海门市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('6aba14ed0d0845489ab32673c894f44d', NULL, NULL, '320723', '23c4b9e3b56e437a8841810d2e8544fd', '灌云县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('6e586d8c71f8499c99fa2f36228bd182', NULL, NULL, '320214', 'cb7fdf26ffc346d08cb29a983aca0d56', '新吴区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('6e7cb75105804be1837e2ff649cce5f5', NULL, NULL, '320903', 'e93fd00029244f4a9fe859672a9bffc3', '盐都区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('714b2a51f193443cb505a08715e8dda8', NULL, NULL, '320981', 'e93fd00029244f4a9fe859672a9bffc3', '东台市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('71ea46965b64492cab3eaf195239c99d', NULL, NULL, '320111', '3a93a5d4e2b2499399461af9aaef7d88', '浦口区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('7535fe37e77446948f06819c6bd2243a', NULL, NULL, '321204', 'a62b36b6761c43cbb41cd9bd74ff8b24', '姜堰区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('773219746e1541af86b65b313287f27a', NULL, NULL, '321322', 'db14d49652e247e4af24140358e1e288', '沭阳县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('787fc1be09c74f2cbc0e3cffa4b075f0', NULL, NULL, '000000', NULL, '中国', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('79348f9e47084290a625d1dd2e07169e', NULL, NULL, '320402', 'fa3ea4e1ca29480cb98e02bce38eb823', '天宁区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('7ce14e525861443bb05ea0ae9bb1de48', NULL, NULL, '320830', '2043be5fb5074621be5498ee53650319', '盱眙县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('8222fe5b8d06408ebdfad88fc00ecd36', NULL, NULL, '320206', 'cb7fdf26ffc346d08cb29a983aca0d56', '惠山区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('83af6c12965245f08160dffb3da8a459', NULL, NULL, '320581', 'e68cc44a4d2447f98fc4239919750efc', '常熟市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('84da855586c64b30bc3eca83581f0ce1', NULL, NULL, '320812', '2043be5fb5074621be5498ee53650319', '清江浦区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('87c73764f8c449cd83fecb22439b5d6a', NULL, NULL, '321203', 'a62b36b6761c43cbb41cd9bd74ff8b24', '高港区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('8dc0ebb796ba499d87af18c0741de3fc', NULL, NULL, '320282', 'cb7fdf26ffc346d08cb29a983aca0d56', '宜兴市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('91f586b389234c989e4af1ae293854d5', NULL, NULL, '320113', '3a93a5d4e2b2499399461af9aaef7d88', '栖霞区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('97184b88f9d349fcb4f57fea6141d3fb', NULL, NULL, '320682', '476e8eb50a1e4371aa3960c7c270b906', '如皋市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('98b41bc2946c4e63b2b07d0089e4c64b', NULL, NULL, '320213', 'cb7fdf26ffc346d08cb29a983aca0d56', '梁溪区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('9a112287158243ae8f2761d409d5372a', NULL, NULL, '320205', 'cb7fdf26ffc346d08cb29a983aca0d56', '锡山区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('9a86e0578c25456fb6d7313e81d1e776', NULL, NULL, '321112', 'ec58bde427fa475b8b5eaca4501f36b7', '丹徒区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('a40f2dd6c6f142d78b6c54b73ffac2ab', NULL, NULL, '320621', '476e8eb50a1e4371aa3960c7c270b906', '海安县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('a53420b7a257465d8be83c7344b103b2', NULL, NULL, '320703', '23c4b9e3b56e437a8841810d2e8544fd', '连云区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('a62b36b6761c43cbb41cd9bd74ff8b24', NULL, NULL, '321200', 'b3850546997b43c1a8960276bb06b720', '泰州市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('a68422122446410b90f9fd0b3ee00699', NULL, NULL, '320505', 'e68cc44a4d2447f98fc4239919750efc', '虎丘区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('aa9b6d77794948f08a12fea793db24eb', NULL, NULL, '321281', 'a62b36b6761c43cbb41cd9bd74ff8b24', '兴化市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('ac891bf085b645e9b3155c833eb22d9e', NULL, NULL, '321183', 'ec58bde427fa475b8b5eaca4501f36b7', '句容市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('adb5b1afdb9249c39316876ad152814c', NULL, NULL, '320116', '3a93a5d4e2b2499399461af9aaef7d88', '六合区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('aea8eef7f3854d94b5d3a774e13f4654', NULL, NULL, '320509', 'e68cc44a4d2447f98fc4239919750efc', '吴江区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b085c258536443268cfe73e2b1d20341', NULL, NULL, '320925', 'e93fd00029244f4a9fe859672a9bffc3', '建湖县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b15fba43a6e14e298347807d0a50aa1e', NULL, NULL, '321311', 'db14d49652e247e4af24140358e1e288', '宿豫区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b1d0d5a5254b4d699dd633aa0cfc4a13', NULL, NULL, '320681', '476e8eb50a1e4371aa3960c7c270b906', '启东市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b3850546997b43c1a8960276bb06b720', NULL, NULL, '320000', '787fc1be09c74f2cbc0e3cffa4b075f0', '江苏省', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b60da5f306094fc9b4d8fd69135402a9', NULL, NULL, '320481', 'fa3ea4e1ca29480cb98e02bce38eb823', '溧阳市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b64d7fdc83774c60bc1544696f33c890', NULL, NULL, '320106', '3a93a5d4e2b2499399461af9aaef7d88', '鼓楼区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b697fb96302248389e7c5af2860ad49a', NULL, '192.168.128.230', '320506', 'e68cc44a4d2447f98fc4239919750efc', '吴中区', NULL, NULL, NULL, '2017-12-04 09:39:30', '1', '2017-12-04 09:39:31');
INSERT INTO `jy_organization_tab` VALUES ('b8253650b4a04f14b61fc0854c2defec', NULL, NULL, '320413', 'fa3ea4e1ca29480cb98e02bce38eb823', '金坛区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b838307fd81f49ac9dd57d0e635e4be3', NULL, NULL, '320831', '2043be5fb5074621be5498ee53650319', '金湖县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b85160adb192477e974a433e3814c39d', NULL, NULL, '321003', '4da7414059ac483ea31ffc60bbcc9577', '邗江区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('b86d594743fc48abb0c205440d8f9cd9', NULL, NULL, '320826', '2043be5fb5074621be5498ee53650319', '涟水县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('c0059795ab2f4353aee63163d4a20416', NULL, NULL, '320583', 'e68cc44a4d2447f98fc4239919750efc', '昆山市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('cb7fdf26ffc346d08cb29a983aca0d56', NULL, NULL, '320200', 'b3850546997b43c1a8960276bb06b720', '无锡市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('d01eceaf5227404ca4bbc53564d26db7', NULL, NULL, '320305', '6071f9a7cdc045ceb98f46eced31f2a2', '贾汪区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('d4977a46640d4cceb0ff865147166f8f', NULL, NULL, '320114', '3a93a5d4e2b2499399461af9aaef7d88', '雨花台区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('da1c3dd89ca944d6a0d974cb24cb20b0', NULL, NULL, '320813', '2043be5fb5074621be5498ee53650319', '洪泽区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('dadb83a8c65543fda2f2e24e67282a2b', NULL, NULL, '321181', 'ec58bde427fa475b8b5eaca4501f36b7', '丹阳市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('db14d49652e247e4af24140358e1e288', NULL, NULL, '321300', 'b3850546997b43c1a8960276bb06b720', '宿迁市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('db52fd3fe4df446b98a64dfe42f7ae6c', NULL, NULL, '320118', '3a93a5d4e2b2499399461af9aaef7d88', '高淳区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('de47177f7c5a4df39653df5088520647', NULL, NULL, '321111', 'ec58bde427fa475b8b5eaca4501f36b7', '润州区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e270bb6c217d4c3e824c7530a9baa274', NULL, NULL, '320706', '23c4b9e3b56e437a8841810d2e8544fd', '海州区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e29eb0bdf93a40a18c1fc9e76617440c', NULL, NULL, '320724', '23c4b9e3b56e437a8841810d2e8544fd', '灌南县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e3d3a18405964f1691a4b2b2191cdf7c', NULL, NULL, '321323', 'db14d49652e247e4af24140358e1e288', '泗阳县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e68cc44a4d2447f98fc4239919750efc', NULL, NULL, '320500', 'b3850546997b43c1a8960276bb06b720', '苏州市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e7b4dd176cbb475aa8f8a502087c84f6', NULL, NULL, '320302', '6071f9a7cdc045ceb98f46eced31f2a2', '鼓楼区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e8bf562edd934ad386f92cf0c90161ef', NULL, NULL, '320411', 'fa3ea4e1ca29480cb98e02bce38eb823', '新北区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('e93fd00029244f4a9fe859672a9bffc3', NULL, NULL, '320900', 'b3850546997b43c1a8960276bb06b720', '盐城市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('ea1569787cf149fcbb413c74864fece8', NULL, NULL, '320102', '3a93a5d4e2b2499399461af9aaef7d88', '玄武区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('eb717bf12afa49b8adaa8648a0f36455', NULL, NULL, '320923', 'e93fd00029244f4a9fe859672a9bffc3', '阜宁县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('ec58bde427fa475b8b5eaca4501f36b7', NULL, NULL, '321100', 'b3850546997b43c1a8960276bb06b720', '镇江市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('f2c9ba6a63e9489eb40ac60e10bdf49f', NULL, NULL, '320904', 'e93fd00029244f4a9fe859672a9bffc3', '大丰区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('f359b29ff9f045b8b24e28ebf268b25b', NULL, NULL, '320585', 'e68cc44a4d2447f98fc4239919750efc', '太仓市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('f5e9bd252e184790b41564de67324830', NULL, NULL, '321182', 'ec58bde427fa475b8b5eaca4501f36b7', '扬中市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('f994e99f84ea43f28e972080a7acf0d5', NULL, NULL, '321002', '4da7414059ac483ea31ffc60bbcc9577', '广陵区', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('fa3ea4e1ca29480cb98e02bce38eb823', NULL, NULL, '320400', 'b3850546997b43c1a8960276bb06b720', '常州市', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('fdd9b996ee0a429ba287a79d2ba226a3', NULL, NULL, '320722', '23c4b9e3b56e437a8841810d2e8544fd', '东海县', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `jy_organization_tab` VALUES ('ffa7d02783cb4ffab3eb48685079e54f', NULL, NULL, '320623', '476e8eb50a1e4371aa3960c7c270b906', '如东县', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for jy_own_org_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_own_org_tab`;
CREATE TABLE `jy_own_org_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `user_id` varchar(32)  NULL DEFAULT NULL COMMENT '用户ID',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '管理机构ID',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Table structure for jy_permission_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_permission_tab`;
CREATE TABLE `jy_permission_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `bsid` varchar(32)  NULL DEFAULT NULL COMMENT 'BSID',
  `permission_name` varchar(100)  NULL DEFAULT NULL COMMENT '权限名称',
  `parent_id` varchar(32)  NULL DEFAULT NULL COMMENT '权限父ID',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_permission_tab
-- ----------------------------
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d113', '00006-00000-00000-00000-00000', '系统设置', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d114', '00005-00001-00000-00000-00000', '个人信息', '4aad35f1de154de281df3f916875d119', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d115', '00005-00002-00000-00000-00000', '密码管理', '4aad35f1de154de281df3f916875d119', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d116', '00006-00001-00000-00000-00000', '角色信息', '4aad35f1de154de281df3f916875d113', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d117', '00006-00002-00000-00000-00000', '组织机构', '4aad35f1de154de281df3f916875d113', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d118', '00006-00003-00000-00000-00000', '用户管理', '4aad35f1de154de281df3f916875d113', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d119', '00005-00000-00000-00000-00000', '个人信息', '', '', 0, 'wb', '2017-07-27 09:33:39', 'wb', '2017-07-27 09:33:46');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d120', '00006-00004-00000-00000-00000', '日志管理', '4aad35f1de154de281df3f916875d113', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d121', '00007-00000-00000-00000-00000', '通信检测', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d122', '00007-00001-00000-00000-00000', '系统检测', '4aad35f1de154de281df3f916875d121', '', 0, 'wb', '2017-10-27 13:56:59', 'wb', '2017-10-27 13:56:59');
INSERT INTO `jy_permission_tab` VALUES ('4aad35f1de154de281df3f916875d123', '00007-00002-00000-00000-00000', '参数配置', '4aad35f1de154de281df3f916875d121', NULL, 0, 'wb', '2017-12-27 11:06:45', 'wb', '2017-12-29 10:43:35');
INSERT INTO `jy_permission_tab` VALUES ('6cc537968d6a42469266b78889b40919', '00003-00003-00000-00000-00000', '还原信号', 'a21aa9b21b244350865bdae31f06d4c7', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('8a1edc19adc94f99852912cbf06d71a1', '00001-00001-00000-00000-00000', '考试计划', '9dbf0e94ccdb44d7a2e5c434e8b8b123', '', 0, 'wb', '2017-10-27 13:48:17', 'wb', '2017-10-27 13:48:17');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e820b120', '00002-00000-00000-00000-00000', '黑白名单', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e821b121', '00002-00001-00000-00000-00000', '黑白名单', '9dbf0e94ccdb44d7a2e5c434e820b120', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e822b120', '00004-00000-00000-00000-00000', '统计分析', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e823b121', '00004-00001-00000-00000-00000', '统计数据', '9dbf0e94ccdb44d7a2e5c434e822b120', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e8b8b120', '00000-00000-00000-00000-00000', '设备管理', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e8b8b121', '00000-00001-00000-00000-00000', '设备展示', '9dbf0e94ccdb44d7a2e5c434e8b8b120', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e8b8b122', '00000-00002-00000-00000-00000', '设备分组', '9dbf0e94ccdb44d7a2e5c434e8b8b120', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-12-27 11:06:23');
INSERT INTO `jy_permission_tab` VALUES ('9dbf0e94ccdb44d7a2e5c434e8b8b123', '00001-00000-00000-00000-00000', '考试管理', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('a21aa9b21b244350865bdae31f06d4c7', '00003-00000-00000-00000-00000', '可疑信号', '', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('bab83e402b004ef2bd6f57428ce3d000', '00001-00003-00000-00000-00000', '考后数据整理', '9dbf0e94ccdb44d7a2e5c434e8b8b123', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');
INSERT INTO `jy_permission_tab` VALUES ('bab83e402b004ef2bd6f57428ce3d84d', '00001-00002-00000-00000-00000', '考试类型', '9dbf0e94ccdb44d7a2e5c434e8b8b123', '', 0, 'wb', '2017-10-23 14:40:39', 'wb', '2017-10-23 14:40:39');

-- ----------------------------
-- Table structure for jy_region_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_region_tab`;
CREATE TABLE `jy_region_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `region_code` varchar(10)  NULL DEFAULT NULL COMMENT '区域CODE',
  `region_name` varchar(100)  NULL DEFAULT NULL COMMENT '区域名称',
  `region_p_id` varchar(32)  NULL DEFAULT NULL COMMENT '区域父ID',
  `region_level` varchar(1)  NULL DEFAULT NULL COMMENT '区域级别',
  `region_order` tinyint(2) NULL DEFAULT NULL COMMENT '区域同级排序顺序',
  `region_name_en` varchar(100)  NULL DEFAULT NULL COMMENT '区域全拼',
  `region_shortname_en` varchar(100)  NULL DEFAULT NULL COMMENT '区域首字母',
  `region_bsid` varchar(29)  NULL DEFAULT NULL COMMENT '区域BSID',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_region_tab
-- ----------------------------
INSERT INTO `jy_region_tab` VALUES ('000000', '000000', '中国', NULL, '1', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110000', '110000', '北京', '000000', '2', 1, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:19:03', NULL, '2017-12-03 18:19:03');
INSERT INTO `jy_region_tab` VALUES ('110100', '110100', '北京市', '110000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:19:00', NULL, '2017-12-03 18:19:00');
INSERT INTO `jy_region_tab` VALUES ('110101', '110101', '东城区', '110100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110102', '110102', '西城区', '110100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110105', '110105', '朝阳区', '110100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110106', '110106', '丰台区', '110100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110107', '110107', '石景山区', '110100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110108', '110108', '海淀区', '110100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110109', '110109', '门头沟区', '110100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110111', '110111', '房山区', '110100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110112', '110112', '通州区', '110100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110113', '110113', '顺义区', '110100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110114', '110114', '昌平区', '110100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110115', '110115', '大兴区', '110100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110116', '110116', '怀柔区', '110100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110117', '110117', '平谷区', '110100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110118', '110118', '密云区', '110100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('110119', '110119', '延庆区', '110100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120000', '120000', '天津', '000000', '2', 2, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:19:07', NULL, '2017-12-03 18:19:07');
INSERT INTO `jy_region_tab` VALUES ('120100', '120100', '天津市', '120000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:19:09', NULL, '2017-12-03 18:19:09');
INSERT INTO `jy_region_tab` VALUES ('120101', '120101', '和平区', '120100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120102', '120102', '河东区', '120100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120103', '120103', '河西区', '120100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120104', '120104', '南开区', '120100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120105', '120105', '河北区', '120100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120106', '120106', '红桥区', '120100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120110', '120110', '东丽区', '120100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120111', '120111', '西青区', '120100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120112', '120112', '津南区', '120100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120113', '120113', '北辰区', '120100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120114', '120114', '武清区', '120100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120115', '120115', '宝坻区', '120100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120116', '120116', '滨海新区', '120100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120117', '120117', '宁河区', '120100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120118', '120118', '静海区', '120100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('120119', '120119', '蓟州区', '120100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130000', '130000', '河北省', '000000', '2', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130100', '130100', '石家庄市', '130000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130102', '130102', '长安区', '130100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130104', '130104', '桥西区', '130100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130105', '130105', '新华区', '130100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130107', '130107', '井陉矿区', '130100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130108', '130108', '裕华区', '130100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130109', '130109', '藁城区', '130100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130110', '130110', '鹿泉区', '130100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130111', '130111', '栾城区', '130100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130121', '130121', '井陉县', '130100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130123', '130123', '正定县', '130100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130125', '130125', '行唐县', '130100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130126', '130126', '灵寿县', '130100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130127', '130127', '高邑县', '130100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130128', '130128', '深泽县', '130100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130129', '130129', '赞皇县', '130100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130130', '130130', '无极县', '130100', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130131', '130131', '平山县', '130100', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130132', '130132', '元氏县', '130100', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130133', '130133', '赵县', '130100', '4', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130183', '130183', '晋州市', '130100', '4', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130184', '130184', '新乐市', '130100', '4', 22, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130200', '130200', '唐山市', '130000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130202', '130202', '路南区', '130200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130203', '130203', '路北区', '130200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130204', '130204', '古冶区', '130200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130205', '130205', '开平区', '130200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130207', '130207', '丰南区', '130200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130208', '130208', '丰润区', '130200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130209', '130209', '曹妃甸区', '130200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130223', '130223', '滦县', '130200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130224', '130224', '滦南县', '130200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130225', '130225', '乐亭县', '130200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130227', '130227', '迁西县', '130200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130229', '130229', '玉田县', '130200', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130281', '130281', '遵化市', '130200', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130283', '130283', '迁安市', '130200', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130300', '130300', '秦皇岛市', '130000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130302', '130302', '海港区', '130300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130303', '130303', '山海关区', '130300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130304', '130304', '北戴河区', '130300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130306', '130306', '抚宁区', '130300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130321', '130321', '青龙满族自治县', '130300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130322', '130322', '昌黎县', '130300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130324', '130324', '卢龙县', '130300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130400', '130400', '邯郸市', '130000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130402', '130402', '邯山区', '130400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130403', '130403', '丛台区', '130400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130404', '130404', '复兴区', '130400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130406', '130406', '峰峰矿区', '130400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130421', '130421', '邯郸县', '130400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130423', '130423', '临漳县', '130400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130424', '130424', '成安县', '130400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130425', '130425', '大名县', '130400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130426', '130426', '涉县', '130400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130427', '130427', '磁县', '130400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130428', '130428', '肥乡县', '130400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130429', '130429', '永年县', '130400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130430', '130430', '邱县', '130400', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130431', '130431', '鸡泽县', '130400', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130432', '130432', '广平县', '130400', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130433', '130433', '馆陶县', '130400', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130434', '130434', '魏县', '130400', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130435', '130435', '曲周县', '130400', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130481', '130481', '武安市', '130400', '4', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130500', '130500', '邢台市', '130000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130502', '130502', '桥东区', '130500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130503', '130503', '桥西区', '130500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130521', '130521', '邢台县', '130500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130522', '130522', '临城县', '130500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130523', '130523', '内丘县', '130500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130524', '130524', '柏乡县', '130500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130525', '130525', '隆尧县', '130500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130526', '130526', '任县', '130500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130527', '130527', '南和县', '130500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130528', '130528', '宁晋县', '130500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130529', '130529', '巨鹿县', '130500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130530', '130530', '新河县', '130500', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130531', '130531', '广宗县', '130500', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130532', '130532', '平乡县', '130500', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130533', '130533', '威县', '130500', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130534', '130534', '清河县', '130500', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130535', '130535', '临西县', '130500', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130581', '130581', '南宫市', '130500', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130582', '130582', '沙河市', '130500', '4', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130600', '130600', '保定市', '130000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130602', '130602', '竞秀区', '130600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130606', '130606', '莲池区', '130600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130607', '130607', '满城区', '130600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130608', '130608', '清苑区', '130600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130609', '130609', '徐水区', '130600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130623', '130623', '涞水县', '130600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130624', '130624', '阜平县', '130600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130626', '130626', '定兴县', '130600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130627', '130627', '唐县', '130600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130628', '130628', '高阳县', '130600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130629', '130629', '容城县', '130600', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130630', '130630', '涞源县', '130600', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130631', '130631', '望都县', '130600', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130632', '130632', '安新县', '130600', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130633', '130633', '易县', '130600', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130634', '130634', '曲阳县', '130600', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130635', '130635', '蠡县', '130600', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130636', '130636', '顺平县', '130600', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130637', '130637', '博野县', '130600', '4', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130638', '130638', '雄县', '130600', '4', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130681', '130681', '涿州市', '130600', '4', 22, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130683', '130683', '安国市', '130600', '4', 23, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130684', '130684', '高碑店市', '130600', '4', 24, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130700', '130700', '张家口市', '130000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130702', '130702', '桥东区', '130700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130703', '130703', '桥西区', '130700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130705', '130705', '宣化区', '130700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130706', '130706', '下花园区', '130700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130708', '130708', '万全区', '130700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130709', '130709', '崇礼区', '130700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130722', '130722', '张北县', '130700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130723', '130723', '康保县', '130700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130724', '130724', '沽源县', '130700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130725', '130725', '尚义县', '130700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130726', '130726', '蔚县', '130700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130727', '130727', '阳原县', '130700', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130728', '130728', '怀安县', '130700', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130730', '130730', '怀来县', '130700', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130731', '130731', '涿鹿县', '130700', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130732', '130732', '赤城县', '130700', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130800', '130800', '承德市', '130000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130802', '130802', '双桥区', '130800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130803', '130803', '双滦区', '130800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130804', '130804', '鹰手营子矿区', '130800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130821', '130821', '承德县', '130800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130822', '130822', '兴隆县', '130800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130823', '130823', '平泉县', '130800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130824', '130824', '滦平县', '130800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130825', '130825', '隆化县', '130800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130826', '130826', '丰宁满族自治县', '130800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130827', '130827', '宽城满族自治县', '130800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130828', '130828', '围场满族蒙古族自治县', '130800', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130900', '130900', '沧州市', '130000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130902', '130902', '新华区', '130900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130903', '130903', '运河区', '130900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130921', '130921', '沧县', '130900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130922', '130922', '青县', '130900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130923', '130923', '东光县', '130900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130924', '130924', '海兴县', '130900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130925', '130925', '盐山县', '130900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130926', '130926', '肃宁县', '130900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130927', '130927', '南皮县', '130900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130928', '130928', '吴桥县', '130900', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130929', '130929', '献县', '130900', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130930', '130930', '孟村回族自治县', '130900', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130981', '130981', '泊头市', '130900', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130982', '130982', '任丘市', '130900', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130983', '130983', '黄骅市', '130900', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('130984', '130984', '河间市', '130900', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131000', '131000', '廊坊市', '130000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131002', '131002', '安次区', '131000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131003', '131003', '广阳区', '131000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131022', '131022', '固安县', '131000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131023', '131023', '永清县', '131000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131024', '131024', '香河县', '131000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131025', '131025', '大城县', '131000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131026', '131026', '文安县', '131000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131028', '131028', '大厂回族自治县', '131000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131081', '131081', '霸州市', '131000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131082', '131082', '三河市', '131000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131100', '131100', '衡水市', '130000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131102', '131102', '桃城区', '131100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131103', '131103', '冀州区', '131100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131121', '131121', '枣强县', '131100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131122', '131122', '武邑县', '131100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131123', '131123', '武强县', '131100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131124', '131124', '饶阳县', '131100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131125', '131125', '安平县', '131100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131126', '131126', '故城县', '131100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131127', '131127', '景县', '131100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131128', '131128', '阜城县', '131100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('131182', '131182', '深州市', '131100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('139000', '139000', '省直辖县级行政区划', '130000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('139001', '139001', '定州市', '139000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('139002', '139002', '辛集市', '139000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140000', '140000', '山西省', '000000', '2', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140100', '140100', '太原市', '140000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140105', '140105', '小店区', '140100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140106', '140106', '迎泽区', '140100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140107', '140107', '杏花岭区', '140100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140108', '140108', '尖草坪区', '140100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140109', '140109', '万柏林区', '140100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140110', '140110', '晋源区', '140100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140121', '140121', '清徐县', '140100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140122', '140122', '阳曲县', '140100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140123', '140123', '娄烦县', '140100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140181', '140181', '古交市', '140100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140200', '140200', '大同市', '140000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140202', '140202', '城区', '140200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140203', '140203', '矿区', '140200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140211', '140211', '南郊区', '140200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140212', '140212', '新荣区', '140200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140221', '140221', '阳高县', '140200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140222', '140222', '天镇县', '140200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140223', '140223', '广灵县', '140200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140224', '140224', '灵丘县', '140200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140225', '140225', '浑源县', '140200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140226', '140226', '左云县', '140200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140227', '140227', '大同县', '140200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140300', '140300', '阳泉市', '140000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140302', '140302', '城区', '140300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140303', '140303', '矿区', '140300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140311', '140311', '郊区', '140300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140321', '140321', '平定县', '140300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140322', '140322', '盂县', '140300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140400', '140400', '长治市', '140000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140402', '140402', '城区', '140400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140411', '140411', '郊区', '140400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140421', '140421', '长治县', '140400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140423', '140423', '襄垣县', '140400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140424', '140424', '屯留县', '140400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140425', '140425', '平顺县', '140400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140426', '140426', '黎城县', '140400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140427', '140427', '壶关县', '140400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140428', '140428', '长子县', '140400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140429', '140429', '武乡县', '140400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140430', '140430', '沁县', '140400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140431', '140431', '沁源县', '140400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140481', '140481', '潞城市', '140400', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140500', '140500', '晋城市', '140000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140502', '140502', '城区', '140500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140521', '140521', '沁水县', '140500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140522', '140522', '阳城县', '140500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140524', '140524', '陵川县', '140500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140525', '140525', '泽州县', '140500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140581', '140581', '高平市', '140500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140600', '140600', '朔州市', '140000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140602', '140602', '朔城区', '140600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140603', '140603', '平鲁区', '140600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140621', '140621', '山阴县', '140600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140622', '140622', '应县', '140600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140623', '140623', '右玉县', '140600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140624', '140624', '怀仁县', '140600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140700', '140700', '晋中市', '140000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140702', '140702', '榆次区', '140700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140721', '140721', '榆社县', '140700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140722', '140722', '左权县', '140700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140723', '140723', '和顺县', '140700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140724', '140724', '昔阳县', '140700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140725', '140725', '寿阳县', '140700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140726', '140726', '太谷县', '140700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140727', '140727', '祁县', '140700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140728', '140728', '平遥县', '140700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140729', '140729', '灵石县', '140700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140781', '140781', '介休市', '140700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140800', '140800', '运城市', '140000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140802', '140802', '盐湖区', '140800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140821', '140821', '临猗县', '140800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140822', '140822', '万荣县', '140800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140823', '140823', '闻喜县', '140800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140824', '140824', '稷山县', '140800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140825', '140825', '新绛县', '140800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140826', '140826', '绛县', '140800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140827', '140827', '垣曲县', '140800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140828', '140828', '夏县', '140800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140829', '140829', '平陆县', '140800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140830', '140830', '芮城县', '140800', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140881', '140881', '永济市', '140800', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140882', '140882', '河津市', '140800', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140900', '140900', '忻州市', '140000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140902', '140902', '忻府区', '140900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140921', '140921', '定襄县', '140900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140922', '140922', '五台县', '140900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140923', '140923', '代县', '140900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140924', '140924', '繁峙县', '140900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140925', '140925', '宁武县', '140900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140926', '140926', '静乐县', '140900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140927', '140927', '神池县', '140900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140928', '140928', '五寨县', '140900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140929', '140929', '岢岚县', '140900', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140930', '140930', '河曲县', '140900', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140931', '140931', '保德县', '140900', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140932', '140932', '偏关县', '140900', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('140981', '140981', '原平市', '140900', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141000', '141000', '临汾市', '140000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141002', '141002', '尧都区', '141000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141021', '141021', '曲沃县', '141000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141022', '141022', '翼城县', '141000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141023', '141023', '襄汾县', '141000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141024', '141024', '洪洞县', '141000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141025', '141025', '古县', '141000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141026', '141026', '安泽县', '141000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141027', '141027', '浮山县', '141000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141028', '141028', '吉县', '141000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141029', '141029', '乡宁县', '141000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141030', '141030', '大宁县', '141000', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141031', '141031', '隰县', '141000', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141032', '141032', '永和县', '141000', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141033', '141033', '蒲县', '141000', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141034', '141034', '汾西县', '141000', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141081', '141081', '侯马市', '141000', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141082', '141082', '霍州市', '141000', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141100', '141100', '吕梁市', '140000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141102', '141102', '离石区', '141100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141121', '141121', '文水县', '141100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141122', '141122', '交城县', '141100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141123', '141123', '兴县', '141100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141124', '141124', '临县', '141100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141125', '141125', '柳林县', '141100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141126', '141126', '石楼县', '141100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141127', '141127', '岚县', '141100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141128', '141128', '方山县', '141100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141129', '141129', '中阳县', '141100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141130', '141130', '交口县', '141100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141181', '141181', '孝义市', '141100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('141182', '141182', '汾阳市', '141100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150000', '150000', '内蒙古自治区', '000000', '2', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150100', '150100', '呼和浩特市', '150000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150102', '150102', '新城区', '150100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150103', '150103', '回民区', '150100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150104', '150104', '玉泉区', '150100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150105', '150105', '赛罕区', '150100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150121', '150121', '土默特左旗', '150100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150122', '150122', '托克托县', '150100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150123', '150123', '和林格尔县', '150100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150124', '150124', '清水河县', '150100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150125', '150125', '武川县', '150100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150200', '150200', '包头市', '150000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150202', '150202', '东河区', '150200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150203', '150203', '昆都仑区', '150200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150204', '150204', '青山区', '150200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150205', '150205', '石拐区', '150200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150206', '150206', '白云鄂博矿区', '150200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150207', '150207', '九原区', '150200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150221', '150221', '土默特右旗', '150200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150222', '150222', '固阳县', '150200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150223', '150223', '达尔罕茂明安联合旗', '150200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150300', '150300', '乌海市', '150000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150302', '150302', '海勃湾区', '150300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150303', '150303', '海南区', '150300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150304', '150304', '乌达区', '150300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150400', '150400', '赤峰市', '150000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150402', '150402', '红山区', '150400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150403', '150403', '元宝山区', '150400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150404', '150404', '松山区', '150400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150421', '150421', '阿鲁科尔沁旗', '150400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150422', '150422', '巴林左旗', '150400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150423', '150423', '巴林右旗', '150400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150424', '150424', '林西县', '150400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150425', '150425', '克什克腾旗', '150400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150426', '150426', '翁牛特旗', '150400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150428', '150428', '喀喇沁旗', '150400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150429', '150429', '宁城县', '150400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150430', '150430', '敖汉旗', '150400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150500', '150500', '通辽市', '150000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150502', '150502', '科尔沁区', '150500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150521', '150521', '科尔沁左翼中旗', '150500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150522', '150522', '科尔沁左翼后旗', '150500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150523', '150523', '开鲁县', '150500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150524', '150524', '库伦旗', '150500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150525', '150525', '奈曼旗', '150500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150526', '150526', '扎鲁特旗', '150500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150581', '150581', '霍林郭勒市', '150500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150600', '150600', '鄂尔多斯市', '150000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150602', '150602', '东胜区', '150600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150603', '150603', '康巴什区', '150600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150621', '150621', '达拉特旗', '150600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150622', '150622', '准格尔旗', '150600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150623', '150623', '鄂托克前旗', '150600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150624', '150624', '鄂托克旗', '150600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150625', '150625', '杭锦旗', '150600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150626', '150626', '乌审旗', '150600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150627', '150627', '伊金霍洛旗', '150600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150700', '150700', '呼伦贝尔市', '150000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150702', '150702', '海拉尔区', '150700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150703', '150703', '扎赉诺尔区', '150700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150721', '150721', '阿荣旗', '150700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150722', '150722', '莫力达瓦达斡尔族自治旗', '150700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150723', '150723', '鄂伦春自治旗', '150700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150724', '150724', '鄂温克族自治旗', '150700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150725', '150725', '陈巴尔虎旗', '150700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150726', '150726', '新巴尔虎左旗', '150700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150727', '150727', '新巴尔虎右旗', '150700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150781', '150781', '满洲里市', '150700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150782', '150782', '牙克石市', '150700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150783', '150783', '扎兰屯市', '150700', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150784', '150784', '额尔古纳市', '150700', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150785', '150785', '根河市', '150700', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150800', '150800', '巴彦淖尔市', '150000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150802', '150802', '临河区', '150800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150821', '150821', '五原县', '150800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150822', '150822', '磴口县', '150800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150823', '150823', '乌拉特前旗', '150800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150824', '150824', '乌拉特中旗', '150800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150825', '150825', '乌拉特后旗', '150800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150826', '150826', '杭锦后旗', '150800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150900', '150900', '乌兰察布市', '150000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150902', '150902', '集宁区', '150900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150921', '150921', '卓资县', '150900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150922', '150922', '化德县', '150900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150923', '150923', '商都县', '150900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150924', '150924', '兴和县', '150900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150925', '150925', '凉城县', '150900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150926', '150926', '察哈尔右翼前旗', '150900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150927', '150927', '察哈尔右翼中旗', '150900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150928', '150928', '察哈尔右翼后旗', '150900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150929', '150929', '四子王旗', '150900', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('150981', '150981', '丰镇市', '150900', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152200', '152200', '兴安盟', '150000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152201', '152201', '乌兰浩特市', '152200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152202', '152202', '阿尔山市', '152200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152221', '152221', '科尔沁右翼前旗', '152200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152222', '152222', '科尔沁右翼中旗', '152200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152223', '152223', '扎赉特旗', '152200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152224', '152224', '突泉县', '152200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152500', '152500', '锡林郭勒盟', '150000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152501', '152501', '二连浩特市', '152500', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152502', '152502', '锡林浩特市', '152500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152522', '152522', '阿巴嘎旗', '152500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152523', '152523', '苏尼特左旗', '152500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152524', '152524', '苏尼特右旗', '152500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152525', '152525', '东乌珠穆沁旗', '152500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152526', '152526', '西乌珠穆沁旗', '152500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152527', '152527', '太仆寺旗', '152500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152528', '152528', '镶黄旗', '152500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152529', '152529', '正镶白旗', '152500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152530', '152530', '正蓝旗', '152500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152531', '152531', '多伦县', '152500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152900', '152900', '阿拉善盟', '150000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152921', '152921', '阿拉善左旗', '152900', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152922', '152922', '阿拉善右旗', '152900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('152923', '152923', '额济纳旗', '152900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210000', '210000', '辽宁省', '000000', '2', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210100', '210100', '沈阳市', '210000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210102', '210102', '和平区', '210100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210103', '210103', '沈河区', '210100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210104', '210104', '大东区', '210100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210105', '210105', '皇姑区', '210100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210106', '210106', '铁西区', '210100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210111', '210111', '苏家屯区', '210100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210112', '210112', '浑南区', '210100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210113', '210113', '沈北新区', '210100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210114', '210114', '于洪区', '210100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210115', '210115', '辽中区', '210100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210123', '210123', '康平县', '210100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210124', '210124', '法库县', '210100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210181', '210181', '新民市', '210100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210200', '210200', '大连市', '210000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210202', '210202', '中山区', '210200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210203', '210203', '西岗区', '210200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210204', '210204', '沙河口区', '210200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210211', '210211', '甘井子区', '210200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210212', '210212', '旅顺口区', '210200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210213', '210213', '金州区', '210200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210214', '210214', '普兰店区', '210200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210224', '210224', '长海县', '210200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210281', '210281', '瓦房店市', '210200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210283', '210283', '庄河市', '210200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210300', '210300', '鞍山市', '210000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210302', '210302', '铁东区', '210300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210303', '210303', '铁西区', '210300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210304', '210304', '立山区', '210300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210311', '210311', '千山区', '210300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210321', '210321', '台安县', '210300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210323', '210323', '岫岩满族自治县', '210300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210381', '210381', '海城市', '210300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210400', '210400', '抚顺市', '210000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210402', '210402', '新抚区', '210400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210403', '210403', '东洲区', '210400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210404', '210404', '望花区', '210400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210411', '210411', '顺城区', '210400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210421', '210421', '抚顺县', '210400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210422', '210422', '新宾满族自治县', '210400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210423', '210423', '清原满族自治县', '210400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210500', '210500', '本溪市', '210000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210502', '210502', '平山区', '210500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210503', '210503', '溪湖区', '210500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210504', '210504', '明山区', '210500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210505', '210505', '南芬区', '210500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210521', '210521', '本溪满族自治县', '210500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210522', '210522', '桓仁满族自治县', '210500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210600', '210600', '丹东市', '210000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210602', '210602', '元宝区', '210600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210603', '210603', '振兴区', '210600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210604', '210604', '振安区', '210600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210624', '210624', '宽甸满族自治县', '210600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210681', '210681', '东港市', '210600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210682', '210682', '凤城市', '210600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210700', '210700', '锦州市', '210000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210702', '210702', '古塔区', '210700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210703', '210703', '凌河区', '210700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210711', '210711', '太和区', '210700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210726', '210726', '黑山县', '210700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210727', '210727', '义县', '210700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210781', '210781', '凌海市', '210700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210782', '210782', '北镇市', '210700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210800', '210800', '营口市', '210000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210802', '210802', '站前区', '210800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210803', '210803', '西市区', '210800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210804', '210804', '鲅鱼圈区', '210800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210811', '210811', '老边区', '210800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210881', '210881', '盖州市', '210800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210882', '210882', '大石桥市', '210800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210900', '210900', '阜新市', '210000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210902', '210902', '海州区', '210900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210903', '210903', '新邱区', '210900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210904', '210904', '太平区', '210900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210905', '210905', '清河门区', '210900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210911', '210911', '细河区', '210900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210921', '210921', '阜新蒙古族自治县', '210900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('210922', '210922', '彰武县', '210900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211000', '211000', '辽阳市', '210000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211002', '211002', '白塔区', '211000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211003', '211003', '文圣区', '211000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211004', '211004', '宏伟区', '211000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211005', '211005', '弓长岭区', '211000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211011', '211011', '太子河区', '211000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211021', '211021', '辽阳县', '211000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211081', '211081', '灯塔市', '211000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211100', '211100', '盘锦市', '210000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211102', '211102', '双台子区', '211100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211103', '211103', '兴隆台区', '211100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211104', '211104', '大洼区', '211100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211122', '211122', '盘山县', '211100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211200', '211200', '铁岭市', '210000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211202', '211202', '银州区', '211200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211204', '211204', '清河区', '211200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211221', '211221', '铁岭县', '211200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211223', '211223', '西丰县', '211200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211224', '211224', '昌图县', '211200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211281', '211281', '调兵山市', '211200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211282', '211282', '开原市', '211200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211300', '211300', '朝阳市', '210000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211302', '211302', '双塔区', '211300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211303', '211303', '龙城区', '211300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211321', '211321', '朝阳县', '211300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211322', '211322', '建平县', '211300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211324', '211324', '喀喇沁左翼蒙古族自治县', '211300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211381', '211381', '北票市', '211300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211382', '211382', '凌源市', '211300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211400', '211400', '葫芦岛市', '210000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211402', '211402', '连山区', '211400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211403', '211403', '龙港区', '211400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211404', '211404', '南票区', '211400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211421', '211421', '绥中县', '211400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211422', '211422', '建昌县', '211400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('211481', '211481', '兴城市', '211400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220000', '220000', '吉林省', '000000', '2', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220100', '220100', '长春市', '220000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220102', '220102', '南关区', '220100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220103', '220103', '宽城区', '220100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220104', '220104', '朝阳区', '220100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220105', '220105', '二道区', '220100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220106', '220106', '绿园区', '220100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220112', '220112', '双阳区', '220100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220113', '220113', '九台区', '220100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220122', '220122', '农安县', '220100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220182', '220182', '榆树市', '220100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220183', '220183', '德惠市', '220100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220200', '220200', '吉林市', '220000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220202', '220202', '昌邑区', '220200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220203', '220203', '龙潭区', '220200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220204', '220204', '船营区', '220200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220211', '220211', '丰满区', '220200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220221', '220221', '永吉县', '220200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220281', '220281', '蛟河市', '220200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220282', '220282', '桦甸市', '220200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220283', '220283', '舒兰市', '220200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220284', '220284', '磐石市', '220200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220300', '220300', '四平市', '220000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220302', '220302', '铁西区', '220300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220303', '220303', '铁东区', '220300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220322', '220322', '梨树县', '220300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220323', '220323', '伊通满族自治县', '220300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220381', '220381', '公主岭市', '220300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220382', '220382', '双辽市', '220300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220400', '220400', '辽源市', '220000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220402', '220402', '龙山区', '220400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220403', '220403', '西安区', '220400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220421', '220421', '东丰县', '220400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220422', '220422', '东辽县', '220400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220500', '220500', '通化市', '220000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220502', '220502', '东昌区', '220500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220503', '220503', '二道江区', '220500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220521', '220521', '通化县', '220500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220523', '220523', '辉南县', '220500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220524', '220524', '柳河县', '220500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220581', '220581', '梅河口市', '220500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220582', '220582', '集安市', '220500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220600', '220600', '白山市', '220000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220602', '220602', '浑江区', '220600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220605', '220605', '江源区', '220600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220621', '220621', '抚松县', '220600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220622', '220622', '靖宇县', '220600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220623', '220623', '长白朝鲜族自治县', '220600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220681', '220681', '临江市', '220600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220700', '220700', '松原市', '220000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220702', '220702', '宁江区', '220700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220721', '220721', '前郭尔罗斯蒙古族自治县', '220700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220722', '220722', '长岭县', '220700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220723', '220723', '乾安县', '220700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220781', '220781', '扶余市', '220700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220800', '220800', '白城市', '220000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220802', '220802', '洮北区', '220800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220821', '220821', '镇赉县', '220800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220822', '220822', '通榆县', '220800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220881', '220881', '洮南市', '220800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('220882', '220882', '大安市', '220800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222400', '222400', '延边朝鲜族自治州', '220000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222401', '222401', '延吉市', '222400', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222402', '222402', '图们市', '222400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222403', '222403', '敦化市', '222400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222404', '222404', '珲春市', '222400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222405', '222405', '龙井市', '222400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222406', '222406', '和龙市', '222400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222424', '222424', '汪清县', '222400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('222426', '222426', '安图县', '222400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230000', '230000', '黑龙江省', '000000', '2', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230100', '230100', '哈尔滨市', '230000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230102', '230102', '道里区', '230100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230103', '230103', '南岗区', '230100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230104', '230104', '道外区', '230100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230108', '230108', '平房区', '230100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230109', '230109', '松北区', '230100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230110', '230110', '香坊区', '230100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230111', '230111', '呼兰区', '230100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230112', '230112', '阿城区', '230100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230113', '230113', '双城区', '230100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230123', '230123', '依兰县', '230100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230124', '230124', '方正县', '230100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230125', '230125', '宾县', '230100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230126', '230126', '巴彦县', '230100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230127', '230127', '木兰县', '230100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230128', '230128', '通河县', '230100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230129', '230129', '延寿县', '230100', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230183', '230183', '尚志市', '230100', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230184', '230184', '五常市', '230100', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230200', '230200', '齐齐哈尔市', '230000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230202', '230202', '龙沙区', '230200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230203', '230203', '建华区', '230200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230204', '230204', '铁锋区', '230200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230205', '230205', '昂昂溪区', '230200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230206', '230206', '富拉尔基区', '230200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230207', '230207', '碾子山区', '230200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230208', '230208', '梅里斯达斡尔族区', '230200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230221', '230221', '龙江县', '230200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230223', '230223', '依安县', '230200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230224', '230224', '泰来县', '230200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230225', '230225', '甘南县', '230200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230227', '230227', '富裕县', '230200', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230229', '230229', '克山县', '230200', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230230', '230230', '克东县', '230200', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230231', '230231', '拜泉县', '230200', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230281', '230281', '讷河市', '230200', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230300', '230300', '鸡西市', '230000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230302', '230302', '鸡冠区', '230300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230303', '230303', '恒山区', '230300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230304', '230304', '滴道区', '230300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230305', '230305', '梨树区', '230300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230306', '230306', '城子河区', '230300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230307', '230307', '麻山区', '230300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230321', '230321', '鸡东县', '230300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230381', '230381', '虎林市', '230300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230382', '230382', '密山市', '230300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230400', '230400', '鹤岗市', '230000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230402', '230402', '向阳区', '230400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230403', '230403', '工农区', '230400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230404', '230404', '南山区', '230400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230405', '230405', '兴安区', '230400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230406', '230406', '东山区', '230400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230407', '230407', '兴山区', '230400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230421', '230421', '萝北县', '230400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230422', '230422', '绥滨县', '230400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230500', '230500', '双鸭山市', '230000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230502', '230502', '尖山区', '230500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230503', '230503', '岭东区', '230500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230505', '230505', '四方台区', '230500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230506', '230506', '宝山区', '230500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230521', '230521', '集贤县', '230500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230522', '230522', '友谊县', '230500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230523', '230523', '宝清县', '230500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230524', '230524', '饶河县', '230500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230600', '230600', '大庆市', '230000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230602', '230602', '萨尔图区', '230600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230603', '230603', '龙凤区', '230600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230604', '230604', '让胡路区', '230600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230605', '230605', '红岗区', '230600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230606', '230606', '大同区', '230600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230621', '230621', '肇州县', '230600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230622', '230622', '肇源县', '230600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230623', '230623', '林甸县', '230600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230624', '230624', '杜尔伯特蒙古族自治县', '230600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230700', '230700', '伊春市', '230000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230702', '230702', '伊春区', '230700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230703', '230703', '南岔区', '230700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230704', '230704', '友好区', '230700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230705', '230705', '西林区', '230700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230706', '230706', '翠峦区', '230700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230707', '230707', '新青区', '230700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230708', '230708', '美溪区', '230700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230709', '230709', '金山屯区', '230700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230710', '230710', '五营区', '230700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230711', '230711', '乌马河区', '230700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230712', '230712', '汤旺河区', '230700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230713', '230713', '带岭区', '230700', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230714', '230714', '乌伊岭区', '230700', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230715', '230715', '红星区', '230700', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230716', '230716', '上甘岭区', '230700', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230722', '230722', '嘉荫县', '230700', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230781', '230781', '铁力市', '230700', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230800', '230800', '佳木斯市', '230000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230803', '230803', '向阳区', '230800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230804', '230804', '前进区', '230800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230805', '230805', '东风区', '230800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230811', '230811', '郊区', '230800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230822', '230822', '桦南县', '230800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230826', '230826', '桦川县', '230800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230828', '230828', '汤原县', '230800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230881', '230881', '同江市', '230800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230882', '230882', '富锦市', '230800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230883', '230883', '抚远市', '230800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230900', '230900', '七台河市', '230000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230902', '230902', '新兴区', '230900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230903', '230903', '桃山区', '230900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230904', '230904', '茄子河区', '230900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('230921', '230921', '勃利县', '230900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231000', '231000', '牡丹江市', '230000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231002', '231002', '东安区', '231000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231003', '231003', '阳明区', '231000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231004', '231004', '爱民区', '231000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231005', '231005', '西安区', '231000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231025', '231025', '林口县', '231000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231081', '231081', '绥芬河市', '231000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231083', '231083', '海林市', '231000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231084', '231084', '宁安市', '231000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231085', '231085', '穆棱市', '231000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231086', '231086', '东宁市', '231000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231100', '231100', '黑河市', '230000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231102', '231102', '爱辉区', '231100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231121', '231121', '嫩江县', '231100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231123', '231123', '逊克县', '231100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231124', '231124', '孙吴县', '231100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231181', '231181', '北安市', '231100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231182', '231182', '五大连池市', '231100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231200', '231200', '绥化市', '230000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231202', '231202', '北林区', '231200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231221', '231221', '望奎县', '231200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231222', '231222', '兰西县', '231200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231223', '231223', '青冈县', '231200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231224', '231224', '庆安县', '231200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231225', '231225', '明水县', '231200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231226', '231226', '绥棱县', '231200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231281', '231281', '安达市', '231200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231282', '231282', '肇东市', '231200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('231283', '231283', '海伦市', '231200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('232700', '232700', '大兴安岭地区', '230000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('232721', '232721', '呼玛县', '232700', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('232722', '232722', '塔河县', '232700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('232723', '232723', '漠河县', '232700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310000', '310000', '上海', '000000', '2', 9, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:20:21', NULL, '2017-12-03 18:20:21');
INSERT INTO `jy_region_tab` VALUES ('310100', '310100', '上海市', '310000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:20:25', NULL, '2017-12-03 18:20:25');
INSERT INTO `jy_region_tab` VALUES ('310101', '310101', '黄浦区', '310100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310104', '310104', '徐汇区', '310100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310105', '310105', '长宁区', '310100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310106', '310106', '静安区', '310100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310107', '310107', '普陀区', '310100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310109', '310109', '虹口区', '310100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310110', '310110', '杨浦区', '310100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310112', '310112', '闵行区', '310100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310113', '310113', '宝山区', '310100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310114', '310114', '嘉定区', '310100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310115', '310115', '浦东新区', '310100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310116', '310116', '金山区', '310100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310117', '310117', '松江区', '310100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310118', '310118', '青浦区', '310100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310120', '310120', '奉贤区', '310100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('310151', '310151', '崇明区', '310100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320000', '320000', '江苏省', '000000', '2', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320100', '320100', '南京市', '320000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320102', '320102', '玄武区', '320100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320104', '320104', '秦淮区', '320100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320105', '320105', '建邺区', '320100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320106', '320106', '鼓楼区', '320100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320111', '320111', '浦口区', '320100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320113', '320113', '栖霞区', '320100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320114', '320114', '雨花台区', '320100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320115', '320115', '江宁区', '320100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320116', '320116', '六合区', '320100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320117', '320117', '溧水区', '320100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320118', '320118', '高淳区', '320100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320200', '320200', '无锡市', '320000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320205', '320205', '锡山区', '320200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320206', '320206', '惠山区', '320200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320211', '320211', '滨湖区', '320200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320213', '320213', '梁溪区', '320200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320214', '320214', '新吴区', '320200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320281', '320281', '江阴市', '320200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320282', '320282', '宜兴市', '320200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320300', '320300', '徐州市', '320000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320302', '320302', '鼓楼区', '320300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320303', '320303', '云龙区', '320300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320305', '320305', '贾汪区', '320300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320311', '320311', '泉山区', '320300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320312', '320312', '铜山区', '320300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320321', '320321', '丰县', '320300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320322', '320322', '沛县', '320300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320324', '320324', '睢宁县', '320300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320381', '320381', '新沂市', '320300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320382', '320382', '邳州市', '320300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320400', '320400', '常州市', '320000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320402', '320402', '天宁区', '320400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320404', '320404', '钟楼区', '320400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320411', '320411', '新北区', '320400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320412', '320412', '武进区', '320400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320413', '320413', '金坛区', '320400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320481', '320481', '溧阳市', '320400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320500', '320500', '苏州市', '320000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320505', '320505', '虎丘区', '320500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320506', '320506', '吴中区', '320500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320507', '320507', '相城区', '320500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320508', '320508', '姑苏区', '320500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320509', '320509', '吴江区', '320500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320581', '320581', '常熟市', '320500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320582', '320582', '张家港市', '320500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320583', '320583', '昆山市', '320500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320585', '320585', '太仓市', '320500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320600', '320600', '南通市', '320000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320602', '320602', '崇川区', '320600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320611', '320611', '港闸区', '320600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320612', '320612', '通州区', '320600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320621', '320621', '海安县', '320600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320623', '320623', '如东县', '320600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320681', '320681', '启东市', '320600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320682', '320682', '如皋市', '320600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320684', '320684', '海门市', '320600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320700', '320700', '连云港市', '320000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320703', '320703', '连云区', '320700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320706', '320706', '海州区', '320700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320707', '320707', '赣榆区', '320700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320722', '320722', '东海县', '320700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320723', '320723', '灌云县', '320700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320724', '320724', '灌南县', '320700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320800', '320800', '淮安市', '320000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320803', '320803', '淮安区', '320800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320804', '320804', '淮阴区', '320800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320812', '320812', '清江浦区', '320800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320813', '320813', '洪泽区', '320800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320826', '320826', '涟水县', '320800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320830', '320830', '盱眙县', '320800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320831', '320831', '金湖县', '320800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320900', '320900', '盐城市', '320000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320902', '320902', '亭湖区', '320900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320903', '320903', '盐都区', '320900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320904', '320904', '大丰区', '320900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320921', '320921', '响水县', '320900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320922', '320922', '滨海县', '320900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320923', '320923', '阜宁县', '320900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320924', '320924', '射阳县', '320900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320925', '320925', '建湖县', '320900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('320981', '320981', '东台市', '320900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321000', '321000', '扬州市', '320000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321002', '321002', '广陵区', '321000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321003', '321003', '邗江区', '321000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321012', '321012', '江都区', '321000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321023', '321023', '宝应县', '321000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321081', '321081', '仪征市', '321000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321084', '321084', '高邮市', '321000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321100', '321100', '镇江市', '320000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321102', '321102', '京口区', '321100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321111', '321111', '润州区', '321100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321112', '321112', '丹徒区', '321100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321181', '321181', '丹阳市', '321100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321182', '321182', '扬中市', '321100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321183', '321183', '句容市', '321100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321200', '321200', '泰州市', '320000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321202', '321202', '海陵区', '321200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321203', '321203', '高港区', '321200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321204', '321204', '姜堰区', '321200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321281', '321281', '兴化市', '321200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321282', '321282', '靖江市', '321200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321283', '321283', '泰兴市', '321200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321300', '321300', '宿迁市', '320000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321302', '321302', '宿城区', '321300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321311', '321311', '宿豫区', '321300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321322', '321322', '沭阳县', '321300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321323', '321323', '泗阳县', '321300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('321324', '321324', '泗洪县', '321300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330000', '330000', '浙江省', '000000', '2', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330100', '330100', '杭州市', '330000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330102', '330102', '上城区', '330100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330103', '330103', '下城区', '330100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330104', '330104', '江干区', '330100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330105', '330105', '拱墅区', '330100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330106', '330106', '西湖区', '330100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330108', '330108', '滨江区', '330100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330109', '330109', '萧山区', '330100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330110', '330110', '余杭区', '330100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330111', '330111', '富阳区', '330100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330122', '330122', '桐庐县', '330100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330127', '330127', '淳安县', '330100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330182', '330182', '建德市', '330100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330185', '330185', '临安市', '330100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330200', '330200', '宁波市', '330000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330203', '330203', '海曙区', '330200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330204', '330204', '江东区', '330200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330205', '330205', '江北区', '330200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330206', '330206', '北仑区', '330200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330211', '330211', '镇海区', '330200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330212', '330212', '鄞州区', '330200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330225', '330225', '象山县', '330200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330226', '330226', '宁海县', '330200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330281', '330281', '余姚市', '330200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330282', '330282', '慈溪市', '330200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330283', '330283', '奉化市', '330200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330300', '330300', '温州市', '330000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330302', '330302', '鹿城区', '330300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330303', '330303', '龙湾区', '330300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330304', '330304', '瓯海区', '330300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330305', '330305', '洞头区', '330300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330324', '330324', '永嘉县', '330300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330326', '330326', '平阳县', '330300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330327', '330327', '苍南县', '330300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330328', '330328', '文成县', '330300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330329', '330329', '泰顺县', '330300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330381', '330381', '瑞安市', '330300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330382', '330382', '乐清市', '330300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330400', '330400', '嘉兴市', '330000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330402', '330402', '南湖区', '330400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330411', '330411', '秀洲区', '330400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330421', '330421', '嘉善县', '330400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330424', '330424', '海盐县', '330400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330481', '330481', '海宁市', '330400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330482', '330482', '平湖市', '330400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330483', '330483', '桐乡市', '330400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330500', '330500', '湖州市', '330000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330502', '330502', '吴兴区', '330500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330503', '330503', '南浔区', '330500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330521', '330521', '德清县', '330500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330522', '330522', '长兴县', '330500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330523', '330523', '安吉县', '330500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330600', '330600', '绍兴市', '330000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330602', '330602', '越城区', '330600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330603', '330603', '柯桥区', '330600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330604', '330604', '上虞区', '330600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330624', '330624', '新昌县', '330600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330681', '330681', '诸暨市', '330600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330683', '330683', '嵊州市', '330600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330700', '330700', '金华市', '330000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330702', '330702', '婺城区', '330700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330703', '330703', '金东区', '330700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330723', '330723', '武义县', '330700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330726', '330726', '浦江县', '330700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330727', '330727', '磐安县', '330700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330781', '330781', '兰溪市', '330700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330782', '330782', '义乌市', '330700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330783', '330783', '东阳市', '330700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330784', '330784', '永康市', '330700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330800', '330800', '衢州市', '330000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330802', '330802', '柯城区', '330800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330803', '330803', '衢江区', '330800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330822', '330822', '常山县', '330800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330824', '330824', '开化县', '330800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330825', '330825', '龙游县', '330800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330881', '330881', '江山市', '330800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330900', '330900', '舟山市', '330000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330902', '330902', '定海区', '330900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330903', '330903', '普陀区', '330900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330921', '330921', '岱山县', '330900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('330922', '330922', '嵊泗县', '330900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331000', '331000', '台州市', '330000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331002', '331002', '椒江区', '331000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331003', '331003', '黄岩区', '331000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331004', '331004', '路桥区', '331000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331021', '331021', '玉环县', '331000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331022', '331022', '三门县', '331000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331023', '331023', '天台县', '331000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331024', '331024', '仙居县', '331000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331081', '331081', '温岭市', '331000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331082', '331082', '临海市', '331000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331100', '331100', '丽水市', '330000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331102', '331102', '莲都区', '331100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331121', '331121', '青田县', '331100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331122', '331122', '缙云县', '331100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331123', '331123', '遂昌县', '331100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331124', '331124', '松阳县', '331100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331125', '331125', '云和县', '331100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331126', '331126', '庆元县', '331100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331127', '331127', '景宁畲族自治县', '331100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('331181', '331181', '龙泉市', '331100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340000', '340000', '安徽省', '000000', '2', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340100', '340100', '合肥市', '340000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340102', '340102', '瑶海区', '340100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340103', '340103', '庐阳区', '340100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340104', '340104', '蜀山区', '340100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340111', '340111', '包河区', '340100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340121', '340121', '长丰县', '340100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340122', '340122', '肥东县', '340100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340123', '340123', '肥西县', '340100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340124', '340124', '庐江县', '340100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340181', '340181', '巢湖市', '340100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340200', '340200', '芜湖市', '340000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340202', '340202', '镜湖区', '340200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340203', '340203', '弋江区', '340200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340207', '340207', '鸠江区', '340200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340208', '340208', '三山区', '340200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340221', '340221', '芜湖县', '340200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340222', '340222', '繁昌县', '340200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340223', '340223', '南陵县', '340200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340225', '340225', '无为县', '340200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340300', '340300', '蚌埠市', '340000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340302', '340302', '龙子湖区', '340300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340303', '340303', '蚌山区', '340300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340304', '340304', '禹会区', '340300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340311', '340311', '淮上区', '340300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340321', '340321', '怀远县', '340300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340322', '340322', '五河县', '340300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340323', '340323', '固镇县', '340300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340400', '340400', '淮南市', '340000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340402', '340402', '大通区', '340400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340403', '340403', '田家庵区', '340400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340404', '340404', '谢家集区', '340400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340405', '340405', '八公山区', '340400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340406', '340406', '潘集区', '340400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340421', '340421', '凤台县', '340400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340422', '340422', '寿县', '340400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340500', '340500', '马鞍山市', '340000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340503', '340503', '花山区', '340500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340504', '340504', '雨山区', '340500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340506', '340506', '博望区', '340500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340521', '340521', '当涂县', '340500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340522', '340522', '含山县', '340500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340523', '340523', '和县', '340500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340600', '340600', '淮北市', '340000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340602', '340602', '杜集区', '340600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340603', '340603', '相山区', '340600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340604', '340604', '烈山区', '340600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340621', '340621', '濉溪县', '340600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340700', '340700', '铜陵市', '340000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340705', '340705', '铜官区', '340700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340706', '340706', '义安区', '340700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340711', '340711', '郊区', '340700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340722', '340722', '枞阳县', '340700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340800', '340800', '安庆市', '340000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340802', '340802', '迎江区', '340800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340803', '340803', '大观区', '340800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340811', '340811', '宜秀区', '340800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340822', '340822', '怀宁县', '340800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340824', '340824', '潜山县', '340800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340825', '340825', '太湖县', '340800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340826', '340826', '宿松县', '340800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340827', '340827', '望江县', '340800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340828', '340828', '岳西县', '340800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('340881', '340881', '桐城市', '340800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341000', '341000', '黄山市', '340000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341002', '341002', '屯溪区', '341000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341003', '341003', '黄山区', '341000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341004', '341004', '徽州区', '341000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341021', '341021', '歙县', '341000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341022', '341022', '休宁县', '341000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341023', '341023', '黟县', '341000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341024', '341024', '祁门县', '341000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341100', '341100', '滁州市', '340000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341102', '341102', '琅琊区', '341100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341103', '341103', '南谯区', '341100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341122', '341122', '来安县', '341100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341124', '341124', '全椒县', '341100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341125', '341125', '定远县', '341100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341126', '341126', '凤阳县', '341100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341181', '341181', '天长市', '341100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341182', '341182', '明光市', '341100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341200', '341200', '阜阳市', '340000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341202', '341202', '颍州区', '341200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341203', '341203', '颍东区', '341200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341204', '341204', '颍泉区', '341200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341221', '341221', '临泉县', '341200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341222', '341222', '太和县', '341200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341225', '341225', '阜南县', '341200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341226', '341226', '颍上县', '341200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341282', '341282', '界首市', '341200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341300', '341300', '宿州市', '340000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341302', '341302', '埇桥区', '341300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341321', '341321', '砀山县', '341300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341322', '341322', '萧县', '341300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341323', '341323', '灵璧县', '341300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341324', '341324', '泗县', '341300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341500', '341500', '六安市', '340000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341502', '341502', '金安区', '341500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341503', '341503', '裕安区', '341500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341504', '341504', '叶集区', '341500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341522', '341522', '霍邱县', '341500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341523', '341523', '舒城县', '341500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341524', '341524', '金寨县', '341500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341525', '341525', '霍山县', '341500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341600', '341600', '亳州市', '340000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341602', '341602', '谯城区', '341600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341621', '341621', '涡阳县', '341600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341622', '341622', '蒙城县', '341600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341623', '341623', '利辛县', '341600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341700', '341700', '池州市', '340000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341702', '341702', '贵池区', '341700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341721', '341721', '东至县', '341700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341722', '341722', '石台县', '341700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341723', '341723', '青阳县', '341700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341800', '341800', '宣城市', '340000', '3', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341802', '341802', '宣州区', '341800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341821', '341821', '郎溪县', '341800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341822', '341822', '广德县', '341800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341823', '341823', '泾县', '341800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341824', '341824', '绩溪县', '341800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341825', '341825', '旌德县', '341800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('341881', '341881', '宁国市', '341800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350000', '350000', '福建省', '000000', '2', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350100', '350100', '福州市', '350000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350102', '350102', '鼓楼区', '350100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350103', '350103', '台江区', '350100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350104', '350104', '仓山区', '350100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350105', '350105', '马尾区', '350100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350111', '350111', '晋安区', '350100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350121', '350121', '闽侯县', '350100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350122', '350122', '连江县', '350100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350123', '350123', '罗源县', '350100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350124', '350124', '闽清县', '350100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350125', '350125', '永泰县', '350100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350128', '350128', '平潭县', '350100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350181', '350181', '福清市', '350100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350182', '350182', '长乐市', '350100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350200', '350200', '厦门市', '350000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350203', '350203', '思明区', '350200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350205', '350205', '海沧区', '350200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350206', '350206', '湖里区', '350200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350211', '350211', '集美区', '350200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350212', '350212', '同安区', '350200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350213', '350213', '翔安区', '350200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350300', '350300', '莆田市', '350000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350302', '350302', '城厢区', '350300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350303', '350303', '涵江区', '350300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350304', '350304', '荔城区', '350300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350305', '350305', '秀屿区', '350300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350322', '350322', '仙游县', '350300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350400', '350400', '三明市', '350000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350402', '350402', '梅列区', '350400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350403', '350403', '三元区', '350400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350421', '350421', '明溪县', '350400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350423', '350423', '清流县', '350400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350424', '350424', '���化县', '350400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350425', '350425', '大田县', '350400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350426', '350426', '尤溪县', '350400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350427', '350427', '沙县', '350400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350428', '350428', '将乐县', '350400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350429', '350429', '泰宁县', '350400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350430', '350430', '建宁县', '350400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350481', '350481', '永安市', '350400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350500', '350500', '泉州市', '350000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350502', '350502', '鲤城区', '350500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350503', '350503', '丰泽区', '350500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350504', '350504', '洛江区', '350500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350505', '350505', '泉港区', '350500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350521', '350521', '惠安县', '350500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350524', '350524', '安溪县', '350500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350525', '350525', '永春县', '350500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350526', '350526', '德化县', '350500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350527', '350527', '金门县', '350500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350581', '350581', '石狮市', '350500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350582', '350582', '晋江市', '350500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350583', '350583', '南安市', '350500', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350600', '350600', '漳州市', '350000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350602', '350602', '芗城区', '350600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350603', '350603', '龙文区', '350600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350622', '350622', '云霄县', '350600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350623', '350623', '漳浦县', '350600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350624', '350624', '诏安县', '350600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350625', '350625', '长泰县', '350600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350626', '350626', '东山县', '350600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350627', '350627', '南靖县', '350600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350628', '350628', '平和县', '350600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350629', '350629', '华安县', '350600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350681', '350681', '龙海市', '350600', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350700', '350700', '南平市', '350000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350702', '350702', '延平区', '350700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350703', '350703', '建阳区', '350700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350721', '350721', '顺昌县', '350700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350722', '350722', '浦城县', '350700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350723', '350723', '光泽县', '350700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350724', '350724', '松溪县', '350700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350725', '350725', '政和县', '350700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350781', '350781', '邵武市', '350700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350782', '350782', '武夷山市', '350700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350783', '350783', '建瓯市', '350700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350800', '350800', '龙岩市', '350000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350802', '350802', '新罗区', '350800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350803', '350803', '永定区', '350800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350821', '350821', '长汀县', '350800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350823', '350823', '上杭县', '350800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350824', '350824', '武平县', '350800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350825', '350825', '连城县', '350800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350881', '350881', '漳平市', '350800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350900', '350900', '宁德市', '350000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350902', '350902', '蕉城区', '350900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350921', '350921', '霞浦县', '350900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350922', '350922', '古田县', '350900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350923', '350923', '屏南县', '350900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350924', '350924', '寿宁县', '350900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350925', '350925', '周宁县', '350900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350926', '350926', '柘荣县', '350900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350981', '350981', '福安市', '350900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('350982', '350982', '福鼎市', '350900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360000', '360000', '江西省', '000000', '2', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360100', '360100', '南昌市', '360000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360102', '360102', '东湖区', '360100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360103', '360103', '西湖区', '360100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360104', '360104', '青云谱区', '360100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360105', '360105', '湾里区', '360100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360111', '360111', '青山湖区', '360100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360112', '360112', '新建区', '360100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360121', '360121', '南昌县', '360100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360123', '360123', '安义县', '360100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360124', '360124', '进贤县', '360100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360200', '360200', '景德镇市', '360000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360202', '360202', '昌江区', '360200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360203', '360203', '珠山区', '360200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360222', '360222', '浮梁县', '360200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360281', '360281', '乐平市', '360200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360300', '360300', '萍乡市', '360000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360302', '360302', '安源区', '360300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360313', '360313', '湘东区', '360300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360321', '360321', '莲花县', '360300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360322', '360322', '上栗县', '360300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360323', '360323', '芦溪县', '360300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360400', '360400', '九江市', '360000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360402', '360402', '濂溪区', '360400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360403', '360403', '浔阳区', '360400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360421', '360421', '九江县', '360400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360423', '360423', '武宁县', '360400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360424', '360424', '修水县', '360400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360425', '360425', '永修县', '360400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360426', '360426', '德安县', '360400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360428', '360428', '都昌县', '360400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360429', '360429', '湖口县', '360400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360430', '360430', '彭泽县', '360400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360481', '360481', '瑞昌市', '360400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360482', '360482', '共青城市', '360400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360483', '360483', '庐山市', '360400', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360500', '360500', '新余市', '360000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360502', '360502', '渝水区', '360500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360521', '360521', '分宜县', '360500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360600', '360600', '鹰潭市', '360000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360602', '360602', '月湖区', '360600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360622', '360622', '余江县', '360600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360681', '360681', '贵溪市', '360600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360700', '360700', '赣州市', '360000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360702', '360702', '章贡区', '360700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360703', '360703', '南康区', '360700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360721', '360721', '赣县', '360700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360722', '360722', '信丰县', '360700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360723', '360723', '大余县', '360700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360724', '360724', '上犹县', '360700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360725', '360725', '崇义县', '360700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360726', '360726', '安远县', '360700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360727', '360727', '龙南县', '360700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360728', '360728', '定南县', '360700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360729', '360729', '全南县', '360700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360730', '360730', '宁都县', '360700', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360731', '360731', '于都县', '360700', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360732', '360732', '兴国县', '360700', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360733', '360733', '会昌县', '360700', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360734', '360734', '寻乌县', '360700', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360735', '360735', '石城县', '360700', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360781', '360781', '瑞金市', '360700', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360800', '360800', '吉安市', '360000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360802', '360802', '吉州区', '360800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360803', '360803', '青原区', '360800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360821', '360821', '吉安县', '360800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360822', '360822', '吉水县', '360800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360823', '360823', '峡江县', '360800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360824', '360824', '新干县', '360800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360825', '360825', '永丰县', '360800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360826', '360826', '泰和县', '360800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360827', '360827', '遂川县', '360800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360828', '360828', '万安县', '360800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360829', '360829', '安福县', '360800', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360830', '360830', '永新县', '360800', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360881', '360881', '井冈山市', '360800', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360900', '360900', '宜春市', '360000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360902', '360902', '袁州区', '360900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360921', '360921', '奉新县', '360900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360922', '360922', '万载县', '360900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360923', '360923', '上高县', '360900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360924', '360924', '宜丰县', '360900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360925', '360925', '靖安县', '360900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360926', '360926', '铜鼓县', '360900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360981', '360981', '丰城市', '360900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360982', '360982', '樟树市', '360900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('360983', '360983', '高安市', '360900', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361000', '361000', '抚州市', '360000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361002', '361002', '临川区', '361000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361021', '361021', '南城县', '361000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361022', '361022', '黎川县', '361000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361023', '361023', '南丰县', '361000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361024', '361024', '崇仁县', '361000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361025', '361025', '乐安县', '361000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361026', '361026', '宜黄县', '361000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361027', '361027', '金溪县', '361000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361028', '361028', '资溪县', '361000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361029', '361029', '东乡县', '361000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361030', '361030', '广昌县', '361000', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361100', '361100', '上饶市', '360000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361102', '361102', '信州区', '361100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361103', '361103', '广丰区', '361100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361121', '361121', '上饶县', '361100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361123', '361123', '玉山县', '361100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361124', '361124', '铅山县', '361100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361125', '361125', '横峰县', '361100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361126', '361126', '弋阳县', '361100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361127', '361127', '余干县', '361100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361128', '361128', '鄱阳县', '361100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361129', '361129', '万年县', '361100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361130', '361130', '婺源县', '361100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('361181', '361181', '德兴市', '361100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370000', '370000', '山东省', '000000', '2', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370100', '370100', '济南市', '370000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370102', '370102', '历下区', '370100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370103', '370103', '市中区', '370100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370104', '370104', '槐荫区', '370100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370105', '370105', '天桥区', '370100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370112', '370112', '历城区', '370100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370113', '370113', '长清区', '370100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370124', '370124', '平阴县', '370100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370125', '370125', '济阳县', '370100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370126', '370126', '商河县', '370100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370181', '370181', '章丘市', '370100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370200', '370200', '青岛市', '370000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370202', '370202', '市南区', '370200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370203', '370203', '市北区', '370200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370211', '370211', '黄岛区', '370200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370212', '370212', '崂山区', '370200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370213', '370213', '李沧区', '370200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370214', '370214', '城阳区', '370200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370281', '370281', '胶州市', '370200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370282', '370282', '即墨市', '370200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370283', '370283', '平度市', '370200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370285', '370285', '莱西市', '370200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370300', '370300', '淄博市', '370000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370302', '370302', '淄川区', '370300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370303', '370303', '张店区', '370300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370304', '370304', '博山区', '370300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370305', '370305', '临淄区', '370300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370306', '370306', '周村区', '370300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370321', '370321', '桓台县', '370300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370322', '370322', '高青县', '370300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370323', '370323', '沂源县', '370300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370400', '370400', '枣庄市', '370000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370402', '370402', '市中区', '370400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370403', '370403', '薛城区', '370400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370404', '370404', '峄城区', '370400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370405', '370405', '台儿庄区', '370400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370406', '370406', '山亭区', '370400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370481', '370481', '滕州市', '370400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370500', '370500', '东营市', '370000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370502', '370502', '东营区', '370500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370503', '370503', '河口区', '370500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370505', '370505', '垦利区', '370500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370522', '370522', '利津县', '370500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370523', '370523', '广饶县', '370500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370600', '370600', '烟台市', '370000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370602', '370602', '芝罘区', '370600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370611', '370611', '福山区', '370600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370612', '370612', '牟平区', '370600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370613', '370613', '莱山区', '370600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370634', '370634', '长岛县', '370600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370681', '370681', '龙口市', '370600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370682', '370682', '莱阳市', '370600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370683', '370683', '莱州市', '370600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370684', '370684', '蓬莱市', '370600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370685', '370685', '招远市', '370600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370686', '370686', '栖霞市', '370600', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370687', '370687', '海阳市', '370600', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370700', '370700', '潍坊市', '370000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370702', '370702', '潍城区', '370700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370703', '370703', '寒亭区', '370700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370704', '370704', '坊子区', '370700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370705', '370705', '奎文区', '370700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370724', '370724', '临朐县', '370700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370725', '370725', '昌乐县', '370700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370781', '370781', '青州市', '370700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370782', '370782', '诸城市', '370700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370783', '370783', '寿光市', '370700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370784', '370784', '安丘市', '370700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370785', '370785', '高密市', '370700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370786', '370786', '昌邑市', '370700', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370800', '370800', '济宁市', '370000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370811', '370811', '任城区', '370800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370812', '370812', '兖州区', '370800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370826', '370826', '微山县', '370800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370827', '370827', '鱼台县', '370800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370828', '370828', '金乡县', '370800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370829', '370829', '嘉祥县', '370800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370830', '370830', '汶上县', '370800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370831', '370831', '泗水县', '370800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370832', '370832', '梁山县', '370800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370881', '370881', '曲阜市', '370800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370883', '370883', '邹城市', '370800', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370900', '370900', '泰安市', '370000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370902', '370902', '泰山区', '370900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370911', '370911', '岱岳区', '370900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370921', '370921', '宁阳县', '370900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370923', '370923', '东平县', '370900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370982', '370982', '新泰市', '370900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('370983', '370983', '肥城市', '370900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371000', '371000', '威海市', '370000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371002', '371002', '环翠区', '371000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371003', '371003', '文登区', '371000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371082', '371082', '荣成市', '371000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371083', '371083', '乳山市', '371000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371100', '371100', '日照市', '370000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371102', '371102', '东港区', '371100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371103', '371103', '岚山区', '371100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371121', '371121', '五莲县', '371100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371122', '371122', '莒县', '371100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371200', '371200', '莱芜市', '370000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371202', '371202', '莱城区', '371200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371203', '371203', '钢城区', '371200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371300', '371300', '临沂市', '370000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371302', '371302', '兰山区', '371300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371311', '371311', '罗庄区', '371300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371312', '371312', '河东区', '371300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371321', '371321', '沂南县', '371300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371322', '371322', '郯城县', '371300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371323', '371323', '沂水县', '371300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371324', '371324', '兰陵县', '371300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371325', '371325', '费县', '371300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371326', '371326', '平邑县', '371300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371327', '371327', '莒南县', '371300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371328', '371328', '蒙阴县', '371300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371329', '371329', '临沭县', '371300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371400', '371400', '德州市', '370000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371402', '371402', '德城区', '371400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371403', '371403', '陵城区', '371400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371422', '371422', '宁津县', '371400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371423', '371423', '庆云县', '371400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371424', '371424', '临邑县', '371400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371425', '371425', '齐河县', '371400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371426', '371426', '平原县', '371400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371427', '371427', '夏津县', '371400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371428', '371428', '武城县', '371400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371481', '371481', '乐陵市', '371400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371482', '371482', '禹城市', '371400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371500', '371500', '聊城市', '370000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371502', '371502', '东昌府区', '371500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371521', '371521', '阳谷县', '371500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371522', '371522', '莘县', '371500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371523', '371523', '茌平县', '371500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371524', '371524', '东阿县', '371500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371525', '371525', '冠县', '371500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371526', '371526', '高唐县', '371500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371581', '371581', '临清市', '371500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371600', '371600', '滨州市', '370000', '3', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371602', '371602', '滨城区', '371600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371603', '371603', '沾化区', '371600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371621', '371621', '惠民县', '371600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371622', '371622', '阳信县', '371600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371623', '371623', '无棣县', '371600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371625', '371625', '博兴县', '371600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371626', '371626', '邹平县', '371600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371700', '371700', '菏泽市', '370000', '3', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371702', '371702', '牡丹区', '371700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371703', '371703', '定陶区', '371700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371721', '371721', '曹县', '371700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371722', '371722', '单县', '371700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371723', '371723', '成武县', '371700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371724', '371724', '巨野县', '371700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371725', '371725', '郓城县', '371700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371726', '371726', '鄄城县', '371700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('371728', '371728', '东明县', '371700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410000', '410000', '河南省', '000000', '2', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410100', '410100', '郑州市', '410000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410102', '410102', '中原区', '410100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410103', '410103', '二七区', '410100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410104', '410104', '管城回族区', '410100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410105', '410105', '金水区', '410100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410106', '410106', '上街区', '410100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410108', '410108', '惠济区', '410100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410122', '410122', '中牟县', '410100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410181', '410181', '巩义市', '410100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410182', '410182', '荥阳市', '410100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410183', '410183', '新密市', '410100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410184', '410184', '新郑市', '410100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410185', '410185', '登封市', '410100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410200', '410200', '开封市', '410000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410202', '410202', '龙亭区', '410200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410203', '410203', '顺河回族区', '410200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410204', '410204', '鼓楼区', '410200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410205', '410205', '禹王台区', '410200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410211', '410211', '金明区', '410200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410212', '410212', '祥符区', '410200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410221', '410221', '杞县', '410200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410222', '410222', '通许县', '410200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410223', '410223', '尉氏县', '410200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410225', '410225', '兰考县', '410200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410300', '410300', '洛阳市', '410000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410302', '410302', '老城区', '410300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410303', '410303', '西工区', '410300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410304', '410304', '瀍河回族区', '410300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410305', '410305', '涧西区', '410300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410306', '410306', '吉利区', '410300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410311', '410311', '洛龙区', '410300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410322', '410322', '孟津县', '410300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410323', '410323', '新安县', '410300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410324', '410324', '栾川县', '410300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410325', '410325', '嵩县', '410300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410326', '410326', '汝阳县', '410300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410327', '410327', '宜阳县', '410300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410328', '410328', '洛宁县', '410300', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410329', '410329', '伊川县', '410300', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410381', '410381', '偃师市', '410300', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410400', '410400', '平顶山市', '410000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410402', '410402', '新华区', '410400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410403', '410403', '卫东区', '410400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410404', '410404', '石龙区', '410400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410411', '410411', '湛河区', '410400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410421', '410421', '宝丰县', '410400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410422', '410422', '叶县', '410400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410423', '410423', '鲁山县', '410400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410425', '410425', '郏县', '410400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410481', '410481', '舞钢市', '410400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410482', '410482', '汝州市', '410400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410500', '410500', '安阳市', '410000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410502', '410502', '文峰区', '410500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410503', '410503', '北关区', '410500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410505', '410505', '殷都区', '410500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410506', '410506', '龙安区', '410500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410522', '410522', '安阳县', '410500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410523', '410523', '汤阴县', '410500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410526', '410526', '滑县', '410500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410527', '410527', '内黄县', '410500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410581', '410581', '林州市', '410500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410600', '410600', '鹤壁市', '410000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410602', '410602', '鹤山区', '410600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410603', '410603', '山城区', '410600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410611', '410611', '淇滨区', '410600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410621', '410621', '浚县', '410600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410622', '410622', '淇县', '410600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410700', '410700', '新乡市', '410000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410702', '410702', '红旗区', '410700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410703', '410703', '卫滨区', '410700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410704', '410704', '凤泉区', '410700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410711', '410711', '牧野区', '410700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410721', '410721', '新乡县', '410700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410724', '410724', '获嘉县', '410700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410725', '410725', '原阳县', '410700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410726', '410726', '延津县', '410700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410727', '410727', '封丘县', '410700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410728', '410728', '长垣县', '410700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410781', '410781', '卫辉市', '410700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410782', '410782', '辉县市', '410700', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410800', '410800', '焦作市', '410000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410802', '410802', '解放区', '410800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410803', '410803', '中站区', '410800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410804', '410804', '马村区', '410800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410811', '410811', '山阳区', '410800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410821', '410821', '修武县', '410800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410822', '410822', '博爱县', '410800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410823', '410823', '武陟县', '410800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410825', '410825', '温县', '410800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410882', '410882', '沁阳市', '410800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410883', '410883', '孟州市', '410800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410900', '410900', '濮阳市', '410000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410902', '410902', '华龙区', '410900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410922', '410922', '清丰县', '410900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410923', '410923', '南乐县', '410900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410926', '410926', '范县', '410900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410927', '410927', '台前县', '410900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('410928', '410928', '濮阳县', '410900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411000', '411000', '许昌市', '410000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411002', '411002', '魏都区', '411000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411023', '411023', '许昌县', '411000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411024', '411024', '鄢陵县', '411000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411025', '411025', '襄城县', '411000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411081', '411081', '禹州市', '411000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411082', '411082', '长葛市', '411000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411100', '411100', '漯河市', '410000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411102', '411102', '源汇区', '411100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411103', '411103', '郾城区', '411100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411104', '411104', '召陵区', '411100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411121', '411121', '舞阳县', '411100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411122', '411122', '临颍县', '411100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411200', '411200', '三门峡市', '410000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411202', '411202', '湖滨区', '411200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411203', '411203', '陕州区', '411200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411221', '411221', '渑池县', '411200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411224', '411224', '卢氏县', '411200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411281', '411281', '义马市', '411200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411282', '411282', '灵宝市', '411200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411300', '411300', '南阳市', '410000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411302', '411302', '宛城区', '411300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411303', '411303', '卧龙区', '411300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411321', '411321', '南召县', '411300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411322', '411322', '方城县', '411300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411323', '411323', '西峡县', '411300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411324', '411324', '镇平县', '411300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411325', '411325', '内乡县', '411300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411326', '411326', '淅川县', '411300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411327', '411327', '社旗县', '411300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411328', '411328', '唐河县', '411300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411329', '411329', '新野县', '411300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411330', '411330', '桐柏县', '411300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411381', '411381', '邓州市', '411300', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411400', '411400', '商丘市', '410000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411402', '411402', '梁园区', '411400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411403', '411403', '睢阳区', '411400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411421', '411421', '民权县', '411400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411422', '411422', '睢县', '411400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411423', '411423', '宁陵县', '411400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411424', '411424', '柘城县', '411400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411425', '411425', '虞城县', '411400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411426', '411426', '夏邑县', '411400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411481', '411481', '永城市', '411400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411500', '411500', '信阳市', '410000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411502', '411502', '浉河区', '411500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411503', '411503', '平桥区', '411500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411521', '411521', '罗山县', '411500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411522', '411522', '光山县', '411500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411523', '411523', '新县', '411500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411524', '411524', '商城县', '411500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411525', '411525', '固始县', '411500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411526', '411526', '潢川县', '411500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411527', '411527', '淮滨县', '411500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411528', '411528', '息县', '411500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411600', '411600', '周口市', '410000', '3', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411602', '411602', '川汇区', '411600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411621', '411621', '扶沟县', '411600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411622', '411622', '西华县', '411600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411623', '411623', '商水县', '411600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411624', '411624', '沈丘县', '411600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411625', '411625', '郸城县', '411600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411626', '411626', '淮阳县', '411600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411627', '411627', '太康县', '411600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411628', '411628', '鹿邑县', '411600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411681', '411681', '项城市', '411600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411700', '411700', '驻马店市', '410000', '3', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411702', '411702', '驿城区', '411700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411721', '411721', '西平县', '411700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411722', '411722', '上蔡县', '411700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411723', '411723', '平舆县', '411700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411724', '411724', '正阳县', '411700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411725', '411725', '确山县', '411700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411726', '411726', '泌阳县', '411700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411727', '411727', '汝南县', '411700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411728', '411728', '遂平县', '411700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('411729', '411729', '新蔡县', '411700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('419000', '419000', '省直辖县级行政区划', '410000', '3', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('419001', '419001', '济源市', '419000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420000', '420000', '湖北省', '000000', '2', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420100', '420100', '武汉市', '420000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420102', '420102', '江岸区', '420100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420103', '420103', '江汉区', '420100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420104', '420104', '硚口区', '420100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420105', '420105', '汉阳区', '420100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420106', '420106', '武昌区', '420100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420107', '420107', '青山区', '420100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420111', '420111', '洪山区', '420100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420112', '420112', '东西湖区', '420100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420113', '420113', '汉南区', '420100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420114', '420114', '蔡甸区', '420100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420115', '420115', '江夏区', '420100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420116', '420116', '黄陂区', '420100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420117', '420117', '新洲区', '420100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420200', '420200', '黄石市', '420000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420202', '420202', '黄石港区', '420200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420203', '420203', '西塞山区', '420200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420204', '420204', '下陆区', '420200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420205', '420205', '铁山区', '420200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420222', '420222', '阳新县', '420200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420281', '420281', '大冶市', '420200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420300', '420300', '十堰市', '420000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420302', '420302', '茅箭区', '420300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420303', '420303', '张湾区', '420300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420304', '420304', '郧阳区', '420300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420322', '420322', '郧西县', '420300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420323', '420323', '竹山县', '420300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420324', '420324', '竹溪县', '420300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420325', '420325', '房县', '420300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420381', '420381', '丹江口市', '420300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420500', '420500', '宜昌市', '420000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420502', '420502', '西陵区', '420500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420503', '420503', '伍家岗区', '420500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420504', '420504', '点军区', '420500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420505', '420505', '猇亭区', '420500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420506', '420506', '夷陵区', '420500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420525', '420525', '远安县', '420500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420526', '420526', '兴山县', '420500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420527', '420527', '秭归县', '420500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420528', '420528', '长阳土家族自治县', '420500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420529', '420529', '五峰土家族自治县', '420500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420581', '420581', '宜都市', '420500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420582', '420582', '当阳市', '420500', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420583', '420583', '枝江市', '420500', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420600', '420600', '襄阳市', '420000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420602', '420602', '襄城区', '420600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420606', '420606', '樊城区', '420600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420607', '420607', '襄州区', '420600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420624', '420624', '南漳县', '420600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420625', '420625', '谷城县', '420600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420626', '420626', '保康县', '420600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420682', '420682', '老河口市', '420600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420683', '420683', '枣阳市', '420600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420684', '420684', '宜城市', '420600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420700', '420700', '鄂州市', '420000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420702', '420702', '梁子湖区', '420700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420703', '420703', '华容区', '420700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420704', '420704', '鄂城区', '420700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420800', '420800', '荆门市', '420000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420802', '420802', '东宝区', '420800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420804', '420804', '掇刀区', '420800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420821', '420821', '京山县', '420800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420822', '420822', '沙洋县', '420800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420881', '420881', '钟祥市', '420800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420900', '420900', '孝感市', '420000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420902', '420902', '孝南区', '420900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420921', '420921', '孝昌县', '420900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420922', '420922', '大悟县', '420900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420923', '420923', '云梦县', '420900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420981', '420981', '应城市', '420900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420982', '420982', '安陆市', '420900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('420984', '420984', '汉川市', '420900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421000', '421000', '荆州市', '420000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421002', '421002', '沙市区', '421000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421003', '421003', '荆州区', '421000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421022', '421022', '公安县', '421000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421023', '421023', '监利县', '421000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421024', '421024', '江陵县', '421000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421081', '421081', '石首市', '421000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421083', '421083', '洪湖市', '421000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421087', '421087', '松滋市', '421000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421100', '421100', '黄冈市', '420000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421102', '421102', '黄州区', '421100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421121', '421121', '团风县', '421100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421122', '421122', '红安县', '421100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421123', '421123', '罗田县', '421100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421124', '421124', '英山县', '421100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421125', '421125', '浠水县', '421100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421126', '421126', '蕲春县', '421100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421127', '421127', '黄梅县', '421100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421181', '421181', '麻城市', '421100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421182', '421182', '武穴市', '421100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421200', '421200', '咸宁市', '420000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421202', '421202', '咸安区', '421200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421221', '421221', '嘉鱼县', '421200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421222', '421222', '通城县', '421200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421223', '421223', '崇阳县', '421200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421224', '421224', '通山县', '421200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421281', '421281', '赤壁市', '421200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421300', '421300', '随州市', '420000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421303', '421303', '曾都区', '421300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421321', '421321', '随县', '421300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('421381', '421381', '广水市', '421300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422800', '422800', '恩施土家族苗族自治州', '420000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422801', '422801', '恩施市', '422800', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422802', '422802', '利川市', '422800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422822', '422822', '建始县', '422800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422823', '422823', '巴东县', '422800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422825', '422825', '宣恩县', '422800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422826', '422826', '咸丰县', '422800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422827', '422827', '来凤县', '422800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('422828', '422828', '鹤峰县', '422800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('429000', '429000', '省直辖县级行政区划', '420000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('429004', '429004', '仙桃市', '429000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('429005', '429005', '潜江市', '429000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('429006', '429006', '天门市', '429000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('429021', '429021', '神农架林区', '429000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430000', '430000', '湖南省', '000000', '2', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430100', '430100', '长沙市', '430000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430102', '430102', '芙蓉区', '430100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430103', '430103', '天心区', '430100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430104', '430104', '岳麓区', '430100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430105', '430105', '开福区', '430100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430111', '430111', '雨花区', '430100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430112', '430112', '望城区', '430100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430121', '430121', '长沙县', '430100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430124', '430124', '宁乡县', '430100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430181', '430181', '浏阳市', '430100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430200', '430200', '株洲市', '430000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430202', '430202', '荷塘区', '430200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430203', '430203', '芦淞区', '430200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430204', '430204', '石峰区', '430200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430211', '430211', '天元区', '430200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430221', '430221', '株洲县', '430200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430223', '430223', '攸县', '430200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430224', '430224', '茶陵县', '430200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430225', '430225', '炎陵县', '430200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430281', '430281', '醴陵市', '430200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430300', '430300', '湘潭市', '430000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430302', '430302', '雨湖区', '430300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430304', '430304', '岳塘区', '430300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430321', '430321', '湘潭县', '430300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430381', '430381', '湘乡市', '430300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430382', '430382', '韶山市', '430300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430400', '430400', '衡阳市', '430000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430405', '430405', '珠晖区', '430400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430406', '430406', '雁峰区', '430400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430407', '430407', '石鼓区', '430400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430408', '430408', '蒸湘区', '430400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430412', '430412', '南岳区', '430400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430421', '430421', '衡阳县', '430400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430422', '430422', '衡南县', '430400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430423', '430423', '衡山县', '430400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430424', '430424', '衡东县', '430400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430426', '430426', '祁东县', '430400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430481', '430481', '耒阳市', '430400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430482', '430482', '常宁市', '430400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430500', '430500', '邵阳市', '430000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430502', '430502', '双清区', '430500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430503', '430503', '大祥区', '430500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430511', '430511', '北塔区', '430500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430521', '430521', '邵东县', '430500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430522', '430522', '新邵县', '430500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430523', '430523', '邵阳县', '430500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430524', '430524', '隆回县', '430500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430525', '430525', '洞口县', '430500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430527', '430527', '绥宁县', '430500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430528', '430528', '新宁县', '430500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430529', '430529', '城步苗族自治县', '430500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430581', '430581', '武冈市', '430500', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430600', '430600', '岳阳市', '430000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430602', '430602', '岳阳楼区', '430600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430603', '430603', '云溪区', '430600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430611', '430611', '君山区', '430600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430621', '430621', '岳阳县', '430600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430623', '430623', '华容县', '430600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430624', '430624', '湘阴县', '430600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430626', '430626', '平江县', '430600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430681', '430681', '汨罗市', '430600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430682', '430682', '临湘市', '430600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430700', '430700', '常德市', '430000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430702', '430702', '武陵区', '430700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430703', '430703', '鼎城区', '430700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430721', '430721', '安乡县', '430700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430722', '430722', '汉寿县', '430700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430723', '430723', '澧县', '430700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430724', '430724', '临澧县', '430700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430725', '430725', '桃源县', '430700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430726', '430726', '石门县', '430700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430781', '430781', '津市市', '430700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430800', '430800', '张家界市', '430000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430802', '430802', '永定区', '430800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430811', '430811', '武陵源区', '430800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430821', '430821', '慈利县', '430800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430822', '430822', '桑植县', '430800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430900', '430900', '益阳市', '430000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430902', '430902', '资阳区', '430900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430903', '430903', '赫山区', '430900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430921', '430921', '南县', '430900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430922', '430922', '桃江县', '430900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430923', '430923', '安化县', '430900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('430981', '430981', '沅江市', '430900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431000', '431000', '郴州市', '430000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431002', '431002', '北湖区', '431000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431003', '431003', '苏仙区', '431000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431021', '431021', '桂阳县', '431000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431022', '431022', '宜章县', '431000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431023', '431023', '永兴县', '431000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431024', '431024', '嘉禾县', '431000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431025', '431025', '临武县', '431000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431026', '431026', '汝城县', '431000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431027', '431027', '桂东县', '431000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431028', '431028', '安仁县', '431000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431081', '431081', '资兴市', '431000', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431100', '431100', '永州市', '430000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431102', '431102', '零陵区', '431100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431103', '431103', '冷水滩区', '431100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431121', '431121', '祁阳县', '431100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431122', '431122', '东安县', '431100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431123', '431123', '双牌县', '431100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431124', '431124', '道县', '431100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431125', '431125', '江永县', '431100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431126', '431126', '宁远县', '431100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431127', '431127', '蓝山县', '431100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431128', '431128', '新田县', '431100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431129', '431129', '江华瑶族自治县', '431100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431200', '431200', '怀化市', '430000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431202', '431202', '鹤城区', '431200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431221', '431221', '中方县', '431200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431222', '431222', '沅陵县', '431200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431223', '431223', '辰溪县', '431200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431224', '431224', '溆浦县', '431200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431225', '431225', '会同县', '431200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431226', '431226', '麻阳苗族自治县', '431200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431227', '431227', '新晃侗族自治县', '431200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431228', '431228', '芷江侗族自治县', '431200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431229', '431229', '靖州苗族侗族自治县', '431200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431230', '431230', '通道侗族自治县', '431200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431281', '431281', '洪江市', '431200', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431300', '431300', '娄底市', '430000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431302', '431302', '娄星区', '431300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431321', '431321', '双峰县', '431300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431322', '431322', '新化县', '431300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431381', '431381', '冷水江市', '431300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('431382', '431382', '涟源市', '431300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433100', '433100', '湘西土家族苗族自治州', '430000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433101', '433101', '吉首市', '433100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433122', '433122', '泸溪县', '433100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433123', '433123', '凤凰县', '433100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433124', '433124', '花垣县', '433100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433125', '433125', '保靖县', '433100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433126', '433126', '古丈县', '433100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433127', '433127', '永顺县', '433100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('433130', '433130', '龙山县', '433100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440000', '440000', '广东省', '000000', '2', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440100', '440100', '广州市', '440000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440103', '440103', '荔湾区', '440100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440104', '440104', '越秀区', '440100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440105', '440105', '海珠区', '440100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440106', '440106', '天河区', '440100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440111', '440111', '白云区', '440100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440112', '440112', '黄埔区', '440100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440113', '440113', '番禺区', '440100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440114', '440114', '花都区', '440100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440115', '440115', '南沙区', '440100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440117', '440117', '从化区', '440100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440118', '440118', '增城区', '440100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440200', '440200', '韶关市', '440000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440203', '440203', '武江区', '440200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440204', '440204', '浈江区', '440200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440205', '440205', '曲江区', '440200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440222', '440222', '始兴县', '440200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440224', '440224', '仁化县', '440200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440229', '440229', '翁源县', '440200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440232', '440232', '乳源瑶族自治县', '440200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440233', '440233', '新丰县', '440200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440281', '440281', '乐昌市', '440200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440282', '440282', '南雄市', '440200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440300', '440300', '深圳市', '440000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440303', '440303', '罗湖区', '440300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440304', '440304', '福田区', '440300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440305', '440305', '南山区', '440300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440306', '440306', '宝安区', '440300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440307', '440307', '龙岗区', '440300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440308', '440308', '盐田区', '440300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440400', '440400', '珠海市', '440000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440402', '440402', '香洲区', '440400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440403', '440403', '斗门区', '440400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440404', '440404', '金湾区', '440400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440500', '440500', '汕头市', '440000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440507', '440507', '龙湖区', '440500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440511', '440511', '金平区', '440500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440512', '440512', '濠江区', '440500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440513', '440513', '潮阳区', '440500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440514', '440514', '潮南区', '440500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440515', '440515', '澄海区', '440500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440523', '440523', '南澳县', '440500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440600', '440600', '佛山市', '440000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440604', '440604', '禅城区', '440600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440605', '440605', '南海区', '440600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440606', '440606', '顺德区', '440600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440607', '440607', '三水区', '440600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440608', '440608', '高明区', '440600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440700', '440700', '江门市', '440000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440703', '440703', '蓬江区', '440700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440704', '440704', '江海区', '440700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440705', '440705', '新会区', '440700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440781', '440781', '台山市', '440700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440783', '440783', '开平市', '440700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440784', '440784', '鹤山市', '440700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440785', '440785', '恩平市', '440700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440800', '440800', '湛江市', '440000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440802', '440802', '赤坎区', '440800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440803', '440803', '霞山区', '440800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440804', '440804', '坡头区', '440800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440811', '440811', '麻章区', '440800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440823', '440823', '遂溪县', '440800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440825', '440825', '徐闻县', '440800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440881', '440881', '廉江市', '440800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440882', '440882', '雷州市', '440800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440883', '440883', '吴川市', '440800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440900', '440900', '茂名市', '440000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440902', '440902', '茂南区', '440900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440904', '440904', '电白区', '440900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440981', '440981', '高州市', '440900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440982', '440982', '化州市', '440900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('440983', '440983', '信宜市', '440900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441200', '441200', '肇庆市', '440000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441202', '441202', '端州区', '441200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441203', '441203', '鼎湖区', '441200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441204', '441204', '高要区', '441200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441223', '441223', '广宁县', '441200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441224', '441224', '怀集县', '441200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441225', '441225', '封开县', '441200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441226', '441226', '德庆县', '441200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441284', '441284', '四会市', '441200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441300', '441300', '惠州市', '440000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441302', '441302', '惠城区', '441300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441303', '441303', '惠阳区', '441300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441322', '441322', '博罗县', '441300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441323', '441323', '惠东县', '441300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441324', '441324', '龙门县', '441300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441400', '441400', '梅州市', '440000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441402', '441402', '梅江区', '441400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441403', '441403', '梅县区', '441400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441422', '441422', '大埔县', '441400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441423', '441423', '丰顺县', '441400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441424', '441424', '五华县', '441400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441426', '441426', '平远县', '441400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441427', '441427', '蕉岭县', '441400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441481', '441481', '兴宁市', '441400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441500', '441500', '汕尾市', '440000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441502', '441502', '城区', '441500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441521', '441521', '海丰县', '441500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441523', '441523', '陆河县', '441500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441581', '441581', '陆丰市', '441500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441600', '441600', '河源市', '440000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441602', '441602', '源城区', '441600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441621', '441621', '紫金县', '441600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441622', '441622', '龙川县', '441600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441623', '441623', '连平县', '441600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441624', '441624', '和平县', '441600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441625', '441625', '东源县', '441600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441700', '441700', '阳江市', '440000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441702', '441702', '江城区', '441700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441704', '441704', '阳东区', '441700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441721', '441721', '阳西县', '441700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441781', '441781', '阳春市', '441700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441800', '441800', '清远市', '440000', '3', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441802', '441802', '清城区', '441800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441803', '441803', '清新区', '441800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441821', '441821', '佛冈县', '441800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441823', '441823', '阳山县', '441800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441825', '441825', '连山壮族瑶族自治县', '441800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441826', '441826', '连南瑶族自治县', '441800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441881', '441881', '英德市', '441800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441882', '441882', '连州市', '441800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('441900', '441900', '东莞市', '440000', '3', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('442000', '442000', '中山市', '440000', '3', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445100', '445100', '潮州市', '440000', '3', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445102', '445102', '湘桥区', '445100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445103', '445103', '潮安区', '445100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445122', '445122', '饶平县', '445100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445200', '445200', '揭阳市', '440000', '3', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445202', '445202', '榕城区', '445200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445203', '445203', '揭东区', '445200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445222', '445222', '揭西县', '445200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445224', '445224', '惠来县', '445200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445281', '445281', '普宁市', '445200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445300', '445300', '云浮市', '440000', '3', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445302', '445302', '云城区', '445300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445303', '445303', '云安区', '445300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445321', '445321', '新兴县', '445300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445322', '445322', '郁南县', '445300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('445381', '445381', '罗定市', '445300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450000', '450000', '广西壮族自治区', '000000', '2', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450100', '450100', '南宁市', '450000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450102', '450102', '兴宁区', '450100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450103', '450103', '青秀区', '450100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450105', '450105', '江南区', '450100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450107', '450107', '西乡塘区', '450100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450108', '450108', '良庆区', '450100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450109', '450109', '邕宁区', '450100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450110', '450110', '武鸣区', '450100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450123', '450123', '隆安县', '450100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450124', '450124', '马山县', '450100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450125', '450125', '上林县', '450100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450126', '450126', '宾阳县', '450100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450127', '450127', '横县', '450100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450200', '450200', '柳州市', '450000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450202', '450202', '城中区', '450200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450203', '450203', '鱼峰区', '450200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450204', '450204', '柳南区', '450200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450205', '450205', '柳北区', '450200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450206', '450206', '柳江区', '450200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450222', '450222', '柳城县', '450200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450223', '450223', '鹿寨县', '450200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450224', '450224', '融安县', '450200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450225', '450225', '融水苗族自治县', '450200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450226', '450226', '三江侗族自治县', '450200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450300', '450300', '桂林市', '450000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450302', '450302', '秀峰区', '450300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450303', '450303', '叠彩区', '450300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450304', '450304', '象山区', '450300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450305', '450305', '七星区', '450300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450311', '450311', '雁山区', '450300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450312', '450312', '临桂区', '450300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450321', '450321', '阳朔县', '450300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450323', '450323', '灵川县', '450300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450324', '450324', '全州县', '450300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450325', '450325', '兴安县', '450300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450326', '450326', '永福县', '450300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450327', '450327', '灌阳县', '450300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450328', '450328', '龙胜各族自治县', '450300', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450329', '450329', '资源县', '450300', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450330', '450330', '平乐县', '450300', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450331', '450331', '荔浦县', '450300', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450332', '450332', '恭城瑶族自治县', '450300', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450400', '450400', '梧州市', '450000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450403', '450403', '万秀区', '450400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450405', '450405', '长洲区', '450400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450406', '450406', '龙圩区', '450400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450421', '450421', '苍梧县', '450400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450422', '450422', '藤县', '450400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450423', '450423', '蒙山县', '450400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450481', '450481', '岑溪市', '450400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450500', '450500', '北海市', '450000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450502', '450502', '海城区', '450500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450503', '450503', '银海区', '450500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450512', '450512', '铁山港区', '450500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450521', '450521', '合浦县', '450500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450600', '450600', '防城港市', '450000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450602', '450602', '港口区', '450600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450603', '450603', '防城区', '450600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450621', '450621', '上思县', '450600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450681', '450681', '东兴市', '450600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450700', '450700', '钦州市', '450000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450702', '450702', '钦南区', '450700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450703', '450703', '钦北区', '450700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450721', '450721', '灵山县', '450700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450722', '450722', '浦北县', '450700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450800', '450800', '贵港市', '450000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450802', '450802', '港北区', '450800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450803', '450803', '港南区', '450800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450804', '450804', '覃塘区', '450800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450821', '450821', '平南县', '450800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450881', '450881', '桂平市', '450800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450900', '450900', '玉林市', '450000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450902', '450902', '玉州区', '450900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450903', '450903', '福绵区', '450900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450921', '450921', '容县', '450900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450922', '450922', '陆川县', '450900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450923', '450923', '博白县', '450900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450924', '450924', '兴业县', '450900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('450981', '450981', '北流市', '450900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451000', '451000', '百色市', '450000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451002', '451002', '右江区', '451000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451021', '451021', '田阳县', '451000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451022', '451022', '田东县', '451000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451023', '451023', '平果县', '451000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451024', '451024', '德保县', '451000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451026', '451026', '那坡县', '451000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451027', '451027', '凌云县', '451000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451028', '451028', '乐业县', '451000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451029', '451029', '田林县', '451000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451030', '451030', '西林县', '451000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451031', '451031', '隆林各族自治县', '451000', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451081', '451081', '靖西市', '451000', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451100', '451100', '贺州市', '450000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451102', '451102', '八步区', '451100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451103', '451103', '平桂区', '451100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451121', '451121', '昭平县', '451100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451122', '451122', '钟山县', '451100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451123', '451123', '富川瑶族自治县', '451100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451200', '451200', '河池市', '450000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451202', '451202', '金城江区', '451200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451221', '451221', '南丹县', '451200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451222', '451222', '天峨县', '451200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451223', '451223', '凤山县', '451200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451224', '451224', '东兰县', '451200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451225', '451225', '罗城仫佬族自治县', '451200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451226', '451226', '环江毛南族自治县', '451200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451227', '451227', '巴马瑶族自治县', '451200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451228', '451228', '都安瑶族自治县', '451200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451229', '451229', '大化瑶族自治县', '451200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451281', '451281', '宜州市', '451200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451300', '451300', '来宾市', '450000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451302', '451302', '兴宾区', '451300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451321', '451321', '忻城县', '451300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451322', '451322', '象州县', '451300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451323', '451323', '武宣县', '451300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451324', '451324', '金秀瑶族自治县', '451300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451381', '451381', '合山市', '451300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451400', '451400', '崇左市', '450000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451402', '451402', '江州区', '451400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451421', '451421', '扶绥县', '451400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451422', '451422', '宁明县', '451400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451423', '451423', '龙州县', '451400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451424', '451424', '大新县', '451400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451425', '451425', '天等县', '451400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('451481', '451481', '凭祥市', '451400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460000', '460000', '海南省', '000000', '2', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460100', '460100', '海口市', '460000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460105', '460105', '秀英区', '460100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460106', '460106', '龙华区', '460100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460107', '460107', '琼山区', '460100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460108', '460108', '美兰区', '460100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460200', '460200', '三亚市', '460000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460202', '460202', '海棠区', '460200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460203', '460203', '吉阳区', '460200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460204', '460204', '天涯区', '460200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460205', '460205', '崖州区', '460200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460300', '460300', '三沙市', '460000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('460400', '460400', '儋州市', '460000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469000', '469000', '省直辖县级行政区划', '460000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469001', '469001', '五指山市', '469000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469002', '469002', '琼海市', '469000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469005', '469005', '文昌市', '469000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469006', '469006', '万宁市', '469000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469007', '469007', '东方市', '469000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469021', '469021', '定安县', '469000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469022', '469022', '屯昌县', '469000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469023', '469023', '澄迈县', '469000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469024', '469024', '临高县', '469000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469025', '469025', '白沙黎族自治县', '469000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469026', '469026', '昌江黎族自治县', '469000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469027', '469027', '乐东黎族自治县', '469000', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469028', '469028', '陵水黎族自治县', '469000', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469029', '469029', '保亭黎族苗族自治县', '469000', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('469030', '469030', '琼中黎族苗族自治县', '469000', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500000', '500000', '重庆', '000000', '2', 22, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:20:52', NULL, '2017-12-03 18:20:52');
INSERT INTO `jy_region_tab` VALUES ('500100', '500100', '重庆市', '500000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-12-03 18:20:58', NULL, '2017-12-03 18:20:58');
INSERT INTO `jy_region_tab` VALUES ('500101', '500101', '万州区', '500100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500102', '500102', '涪陵区', '500100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500103', '500103', '渝中区', '500100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500104', '500104', '大渡口区', '500100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500105', '500105', '江北区', '500100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500106', '500106', '沙坪坝区', '500100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500107', '500107', '九龙坡区', '500100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500108', '500108', '南岸区', '500100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500109', '500109', '北碚区', '500100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500110', '500110', '綦江区', '500100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500111', '500111', '大足区', '500100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500112', '500112', '渝北区', '500100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500113', '500113', '巴南区', '500100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500114', '500114', '黔江区', '500100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500115', '500115', '长寿区', '500100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500116', '500116', '江津区', '500100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500117', '500117', '合川区', '500100', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500118', '500118', '永川区', '500100', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500119', '500119', '南川区', '500100', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500120', '500120', '璧山区', '500100', '4', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500151', '500151', '铜梁区', '500100', '4', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500152', '500152', '潼南区', '500100', '4', 22, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500153', '500153', '荣昌区', '500100', '4', 23, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500154', '500154', '开州区', '500100', '4', 24, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500200', '500200', '县', '500000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500228', '500228', '梁平县', '500200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500229', '500229', '城口县', '500200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500230', '500230', '丰都县', '500200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500231', '500231', '垫江县', '500200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500232', '500232', '武隆县', '500200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500233', '500233', '忠县', '500200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500235', '500235', '云阳县', '500200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500236', '500236', '奉节县', '500200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500237', '500237', '巫山县', '500200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500238', '500238', '巫溪县', '500200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500240', '500240', '石柱土家族自治县', '500200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500241', '500241', '秀山土家族苗族自治县', '500200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500242', '500242', '酉阳土家族苗族自治县', '500200', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('500243', '500243', '彭水苗族土家族自治县', '500200', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510000', '510000', '四川省', '000000', '2', 23, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510100', '510100', '成都市', '510000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510104', '510104', '锦江区', '510100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510105', '510105', '青羊区', '510100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510106', '510106', '金牛区', '510100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510107', '510107', '武侯区', '510100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510108', '510108', '成华区', '510100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510112', '510112', '龙泉驿区', '510100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510113', '510113', '青白江区', '510100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510114', '510114', '新都区', '510100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510115', '510115', '温江区', '510100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510116', '510116', '双流区', '510100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510121', '510121', '金堂县', '510100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510124', '510124', '郫县', '510100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510129', '510129', '大邑县', '510100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510131', '510131', '蒲江县', '510100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510132', '510132', '新津县', '510100', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510181', '510181', '都江堰市', '510100', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510182', '510182', '彭州市', '510100', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510183', '510183', '邛崃市', '510100', '4', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510184', '510184', '崇州市', '510100', '4', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510185', '510185', '简阳市', '510100', '4', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510300', '510300', '自贡市', '510000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510302', '510302', '自流井区', '510300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510303', '510303', '贡井区', '510300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510304', '510304', '大安区', '510300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510311', '510311', '沿滩区', '510300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510321', '510321', '荣县', '510300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510322', '510322', '富顺县', '510300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510400', '510400', '攀枝花市', '510000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510402', '510402', '东区', '510400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510403', '510403', '西区', '510400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510411', '510411', '仁和区', '510400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510421', '510421', '米易县', '510400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510422', '510422', '盐边县', '510400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510500', '510500', '泸州市', '510000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510502', '510502', '江阳区', '510500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510503', '510503', '纳溪区', '510500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510504', '510504', '龙马潭区', '510500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510521', '510521', '泸县', '510500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510522', '510522', '合江县', '510500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510524', '510524', '叙永县', '510500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510525', '510525', '古蔺县', '510500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510600', '510600', '德阳市', '510000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510603', '510603', '旌阳区', '510600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510623', '510623', '中江县', '510600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510626', '510626', '罗江县', '510600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510681', '510681', '广汉市', '510600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510682', '510682', '什邡市', '510600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510683', '510683', '绵竹市', '510600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510700', '510700', '绵阳市', '510000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510703', '510703', '涪城区', '510700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510704', '510704', '游仙区', '510700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510705', '510705', '安州区', '510700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510722', '510722', '三台县', '510700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510723', '510723', '盐亭县', '510700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510725', '510725', '梓潼县', '510700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510726', '510726', '北川羌族自治县', '510700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510727', '510727', '平武县', '510700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510781', '510781', '江油市', '510700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510800', '510800', '广元市', '510000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510802', '510802', '利州区', '510800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510811', '510811', '昭化区', '510800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510812', '510812', '朝天区', '510800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510821', '510821', '旺苍县', '510800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510822', '510822', '青川县', '510800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510823', '510823', '剑阁县', '510800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510824', '510824', '苍溪县', '510800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510900', '510900', '遂宁市', '510000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510903', '510903', '船山区', '510900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510904', '510904', '安居区', '510900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510921', '510921', '蓬溪县', '510900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510922', '510922', '射洪县', '510900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('510923', '510923', '大英县', '510900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511000', '511000', '内江市', '510000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511002', '511002', '市中区', '511000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511011', '511011', '东兴区', '511000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511024', '511024', '威远县', '511000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511025', '511025', '资中县', '511000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511028', '511028', '隆昌县', '511000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511100', '511100', '乐山市', '510000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511102', '511102', '市中区', '511100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511111', '511111', '沙湾区', '511100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511112', '511112', '五通桥区', '511100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511113', '511113', '金口河区', '511100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511123', '511123', '犍为县', '511100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511124', '511124', '井研县', '511100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511126', '511126', '夹江县', '511100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511129', '511129', '沐川县', '511100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511132', '511132', '峨边彝族自治县', '511100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511133', '511133', '马边彝族自治县', '511100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511181', '511181', '峨眉山市', '511100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511300', '511300', '南充市', '510000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511302', '511302', '顺庆区', '511300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511303', '511303', '高坪区', '511300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511304', '511304', '嘉陵区', '511300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511321', '511321', '南部县', '511300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511322', '511322', '营山县', '511300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511323', '511323', '蓬安县', '511300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511324', '511324', '仪陇县', '511300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511325', '511325', '西充县', '511300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511381', '511381', '阆中市', '511300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511400', '511400', '眉山市', '510000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511402', '511402', '东坡区', '511400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511403', '511403', '彭山区', '511400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511421', '511421', '仁寿县', '511400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511423', '511423', '洪雅县', '511400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511424', '511424', '丹棱县', '511400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511425', '511425', '青神县', '511400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511500', '511500', '宜宾市', '510000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511502', '511502', '翠屏区', '511500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511503', '511503', '南溪区', '511500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511521', '511521', '宜宾县', '511500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511523', '511523', '江安县', '511500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511524', '511524', '长宁县', '511500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511525', '511525', '高县', '511500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511526', '511526', '珙县', '511500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511527', '511527', '筠连县', '511500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511528', '511528', '兴文县', '511500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511529', '511529', '屏山县', '511500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511600', '511600', '广安市', '510000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511602', '511602', '广安区', '511600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511603', '511603', '前锋区', '511600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511621', '511621', '岳池县', '511600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511622', '511622', '武胜县', '511600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511623', '511623', '邻水县', '511600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511681', '511681', '华蓥市', '511600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511700', '511700', '达州市', '510000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511702', '511702', '通川区', '511700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511703', '511703', '达川区', '511700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511722', '511722', '宣汉县', '511700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511723', '511723', '开江县', '511700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511724', '511724', '大竹县', '511700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511725', '511725', '渠县', '511700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511781', '511781', '万源市', '511700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511800', '511800', '雅安市', '510000', '3', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511802', '511802', '雨城区', '511800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511803', '511803', '名山区', '511800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511822', '511822', '荥经县', '511800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511823', '511823', '汉源县', '511800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511824', '511824', '石棉县', '511800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511825', '511825', '天全县', '511800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511826', '511826', '芦山县', '511800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511827', '511827', '宝兴县', '511800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511900', '511900', '巴中市', '510000', '3', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511902', '511902', '巴州区', '511900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511903', '511903', '恩阳区', '511900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511921', '511921', '通江县', '511900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511922', '511922', '南江县', '511900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('511923', '511923', '平昌县', '511900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('512000', '512000', '资阳市', '510000', '3', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('512002', '512002', '雁江区', '512000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('512021', '512021', '安岳县', '512000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('512022', '512022', '乐至县', '512000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513200', '513200', '阿坝藏族羌族自治州', '510000', '3', 19, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513201', '513201', '马尔康市', '513200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513221', '513221', '汶川县', '513200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513222', '513222', '理县', '513200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513223', '513223', '茂县', '513200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513224', '513224', '松潘县', '513200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513225', '513225', '九寨沟县', '513200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513226', '513226', '金川县', '513200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513227', '513227', '小金县', '513200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513228', '513228', '黑水县', '513200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513230', '513230', '壤塘县', '513200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513231', '513231', '阿坝县', '513200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513232', '513232', '若尔盖县', '513200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513233', '513233', '红原县', '513200', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513300', '513300', '甘孜藏族自治州', '510000', '3', 20, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513301', '513301', '康定市', '513300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513322', '513322', '泸定县', '513300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513323', '513323', '丹巴县', '513300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513324', '513324', '九龙县', '513300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513325', '513325', '雅江县', '513300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513326', '513326', '道孚县', '513300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513327', '513327', '炉霍县', '513300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513328', '513328', '甘孜县', '513300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513329', '513329', '新龙县', '513300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513330', '513330', '德格县', '513300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513331', '513331', '白玉县', '513300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513332', '513332', '石渠县', '513300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513333', '513333', '色达县', '513300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513334', '513334', '理塘县', '513300', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513335', '513335', '巴塘县', '513300', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513336', '513336', '乡城县', '513300', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513337', '513337', '稻城县', '513300', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513338', '513338', '得荣县', '513300', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513400', '513400', '凉山彝族自治州', '510000', '3', 21, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513401', '513401', '西昌市', '513400', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513422', '513422', '木里藏族自治县', '513400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513423', '513423', '盐源县', '513400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513424', '513424', '德昌县', '513400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513425', '513425', '会理县', '513400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513426', '513426', '会东县', '513400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513427', '513427', '宁南县', '513400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513428', '513428', '普格县', '513400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513429', '513429', '布拖县', '513400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513430', '513430', '金阳县', '513400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513431', '513431', '昭觉县', '513400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513432', '513432', '喜德县', '513400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513433', '513433', '冕宁县', '513400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513434', '513434', '越西县', '513400', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513435', '513435', '甘洛县', '513400', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513436', '513436', '美姑县', '513400', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('513437', '513437', '雷波县', '513400', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520000', '520000', '贵州省', '000000', '2', 24, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520100', '520100', '贵阳市', '520000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520102', '520102', '南明区', '520100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520103', '520103', '云岩区', '520100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520111', '520111', '花溪区', '520100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520112', '520112', '乌当区', '520100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520113', '520113', '白云区', '520100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520115', '520115', '观山湖区', '520100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520121', '520121', '开阳县', '520100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520122', '520122', '息烽县', '520100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520123', '520123', '修文县', '520100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520181', '520181', '清镇市', '520100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520200', '520200', '六盘水市', '520000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520201', '520201', '钟山区', '520200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520203', '520203', '六枝特区', '520200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520221', '520221', '水城县', '520200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520222', '520222', '盘县', '520200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520300', '520300', '遵义市', '520000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520302', '520302', '红花岗区', '520300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520303', '520303', '汇川区', '520300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520304', '520304', '播州区', '520300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520322', '520322', '桐梓县', '520300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520323', '520323', '绥阳县', '520300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520324', '520324', '正安县', '520300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520325', '520325', '道真仡佬族苗族自治县', '520300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520326', '520326', '务川仡佬族苗族自治县', '520300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520327', '520327', '凤冈县', '520300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520328', '520328', '湄潭县', '520300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520329', '520329', '余庆县', '520300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520330', '520330', '习水县', '520300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520381', '520381', '赤水市', '520300', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520382', '520382', '仁怀市', '520300', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520400', '520400', '安顺市', '520000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520402', '520402', '西秀区', '520400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520403', '520403', '平坝区', '520400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520422', '520422', '普定县', '520400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520423', '520423', '镇宁布依族苗族自治县', '520400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520424', '520424', '关岭布依族苗族自治县', '520400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520425', '520425', '紫云苗族布依族自治县', '520400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520500', '520500', '毕节市', '520000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520502', '520502', '七星关区', '520500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520521', '520521', '大方县', '520500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520522', '520522', '黔西县', '520500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520523', '520523', '金沙县', '520500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520524', '520524', '织金县', '520500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520525', '520525', '纳雍县', '520500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520526', '520526', '威宁彝族回族苗族自治县', '520500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520527', '520527', '赫章县', '520500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520600', '520600', '铜仁市', '520000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520602', '520602', '碧江区', '520600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520603', '520603', '万山区', '520600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520621', '520621', '江口县', '520600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520622', '520622', '玉屏侗族自治县', '520600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520623', '520623', '石阡县', '520600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520624', '520624', '思南县', '520600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520625', '520625', '印江土家族苗族自治县', '520600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520626', '520626', '德江县', '520600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520627', '520627', '沿河土家族自治县', '520600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('520628', '520628', '松桃苗族自治县', '520600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522300', '522300', '黔西南布依族苗族自治州', '520000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522301', '522301', '兴义市', '522300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522322', '522322', '兴仁县', '522300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522323', '522323', '普安县', '522300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522324', '522324', '晴隆县', '522300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522325', '522325', '贞丰县', '522300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522326', '522326', '望谟县', '522300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522327', '522327', '册亨县', '522300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522328', '522328', '安龙县', '522300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522600', '522600', '黔东南苗族侗族自治州', '520000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522601', '522601', '凯里市', '522600', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522622', '522622', '黄平县', '522600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522623', '522623', '施秉县', '522600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522624', '522624', '三穗县', '522600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522625', '522625', '镇远县', '522600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522626', '522626', '岑巩县', '522600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522627', '522627', '天柱县', '522600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522628', '522628', '锦屏县', '522600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522629', '522629', '剑河县', '522600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522630', '522630', '台江县', '522600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522631', '522631', '黎平县', '522600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522632', '522632', '榕江县', '522600', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522633', '522633', '从江县', '522600', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522634', '522634', '雷山县', '522600', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522635', '522635', '麻江县', '522600', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522636', '522636', '丹寨县', '522600', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522700', '522700', '黔南布依族苗族自治州', '520000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522701', '522701', '都匀市', '522700', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522702', '522702', '福泉市', '522700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522722', '522722', '荔波县', '522700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522723', '522723', '贵定县', '522700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522725', '522725', '瓮安县', '522700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522726', '522726', '独山县', '522700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522727', '522727', '平塘县', '522700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522728', '522728', '罗甸县', '522700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522729', '522729', '长顺县', '522700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522730', '522730', '龙里县', '522700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522731', '522731', '惠水县', '522700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('522732', '522732', '三都水族自治县', '522700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530000', '530000', '云南省', '000000', '2', 25, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530100', '530100', '昆明市', '530000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530102', '530102', '五华区', '530100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530103', '530103', '盘龙区', '530100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530111', '530111', '官渡区', '530100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530112', '530112', '西山区', '530100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530113', '530113', '东川区', '530100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530114', '530114', '呈贡区', '530100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530122', '530122', '晋宁县', '530100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530124', '530124', '富民县', '530100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530125', '530125', '宜良县', '530100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530126', '530126', '石林彝族自治县', '530100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530127', '530127', '嵩明县', '530100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530128', '530128', '禄劝彝族苗族自治县', '530100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530129', '530129', '寻甸回族彝族自治县', '530100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530181', '530181', '安宁市', '530100', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530300', '530300', '曲靖市', '530000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530302', '530302', '麒麟区', '530300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530303', '530303', '沾益区', '530300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530321', '530321', '马龙县', '530300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530322', '530322', '陆良县', '530300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530323', '530323', '师宗县', '530300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530324', '530324', '罗平县', '530300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530325', '530325', '富源县', '530300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530326', '530326', '会泽县', '530300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530381', '530381', '宣威市', '530300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530400', '530400', '玉溪市', '530000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530402', '530402', '红塔区', '530400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530403', '530403', '江川区', '530400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530422', '530422', '澄江县', '530400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530423', '530423', '通海县', '530400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530424', '530424', '华宁县', '530400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530425', '530425', '易门县', '530400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530426', '530426', '峨山彝族自治县', '530400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530427', '530427', '新平彝族傣族自治县', '530400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530428', '530428', '元江哈尼族彝族傣族自治县', '530400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530500', '530500', '保山市', '530000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530502', '530502', '隆阳区', '530500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530521', '530521', '施甸县', '530500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530523', '530523', '龙陵县', '530500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530524', '530524', '昌宁县', '530500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530581', '530581', '腾冲市', '530500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530600', '530600', '昭通市', '530000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530602', '530602', '昭阳区', '530600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530621', '530621', '鲁甸县', '530600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530622', '530622', '巧家县', '530600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530623', '530623', '盐津县', '530600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530624', '530624', '大关县', '530600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530625', '530625', '永善县', '530600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530626', '530626', '绥江县', '530600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530627', '530627', '镇雄县', '530600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530628', '530628', '彝良县', '530600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530629', '530629', '威信县', '530600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530630', '530630', '水富县', '530600', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530700', '530700', '丽江市', '530000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530702', '530702', '古城区', '530700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530721', '530721', '玉龙纳西族自治县', '530700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530722', '530722', '永胜县', '530700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530723', '530723', '华坪县', '530700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530724', '530724', '宁蒗彝族自治县', '530700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530800', '530800', '普洱市', '530000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530802', '530802', '思茅区', '530800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530821', '530821', '宁洱哈尼族彝族自治县', '530800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530822', '530822', '墨江哈尼族自治县', '530800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530823', '530823', '景东彝族自治县', '530800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530824', '530824', '景谷傣族彝族自治县', '530800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530825', '530825', '镇沅彝族哈尼族拉祜族自治县', '530800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530826', '530826', '江城哈尼族彝族自治县', '530800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530827', '530827', '孟连傣族拉祜族佤族自治县', '530800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530828', '530828', '澜沧拉祜族自治县', '530800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530829', '530829', '西盟佤族自治县', '530800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530900', '530900', '临沧市', '530000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530902', '530902', '临翔区', '530900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530921', '530921', '凤庆县', '530900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530922', '530922', '云县', '530900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530923', '530923', '永德县', '530900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530924', '530924', '镇康县', '530900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530925', '530925', '双江拉祜族佤族布朗族傣族自治县', '530900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530926', '530926', '耿马傣族佤族自治县', '530900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('530927', '530927', '沧源佤族自治县', '530900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532300', '532300', '楚雄彝族自治州', '530000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532301', '532301', '楚雄市', '532300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532322', '532322', '双柏县', '532300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532323', '532323', '牟定县', '532300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532324', '532324', '南华县', '532300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532325', '532325', '姚安县', '532300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532326', '532326', '大姚县', '532300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532327', '532327', '永仁县', '532300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532328', '532328', '元谋县', '532300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532329', '532329', '武定县', '532300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532331', '532331', '禄丰县', '532300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532500', '532500', '红河哈尼族彝族自治州', '530000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532501', '532501', '个旧市', '532500', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532502', '532502', '开远市', '532500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532503', '532503', '蒙自市', '532500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532504', '532504', '弥勒市', '532500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532523', '532523', '屏边苗族自治县', '532500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532524', '532524', '建水县', '532500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532525', '532525', '石屏县', '532500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532527', '532527', '��西县', '532500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532528', '532528', '元阳县', '532500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532529', '532529', '红河县', '532500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532530', '532530', '金平苗族瑶族傣族自治县', '532500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532531', '532531', '绿春县', '532500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532532', '532532', '河口瑶族自治县', '532500', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532600', '532600', '文山壮族苗族自治州', '530000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532601', '532601', '文山市', '532600', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532622', '532622', '砚山县', '532600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532623', '532623', '西畴县', '532600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532624', '532624', '麻栗坡县', '532600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532625', '532625', '马关县', '532600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532626', '532626', '丘北县', '532600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532627', '532627', '广南县', '532600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532628', '532628', '富宁县', '532600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532800', '532800', '西双版纳傣族自治州', '530000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532801', '532801', '景洪市', '532800', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532822', '532822', '勐海县', '532800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532823', '532823', '勐腊县', '532800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532900', '532900', '大理白族自治州', '530000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532901', '532901', '大理市', '532900', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532922', '532922', '漾濞彝族自治县', '532900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532923', '532923', '祥云县', '532900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532924', '532924', '宾川县', '532900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532925', '532925', '弥渡县', '532900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532926', '532926', '南涧彝族自治县', '532900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532927', '532927', '巍山彝族回族自治县', '532900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532928', '532928', '永平县', '532900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532929', '532929', '云龙县', '532900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532930', '532930', '洱源县', '532900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532931', '532931', '剑川县', '532900', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('532932', '532932', '鹤庆县', '532900', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533100', '533100', '德宏傣族景颇族自治州', '530000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533102', '533102', '瑞丽市', '533100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533103', '533103', '芒市', '533100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533122', '533122', '梁河县', '533100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533123', '533123', '盈江县', '533100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533124', '533124', '陇川县', '533100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533300', '533300', '怒江傈僳族自治州', '530000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533301', '533301', '泸水市', '533300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533323', '533323', '福贡县', '533300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533324', '533324', '贡山独龙族怒族自治县', '533300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533325', '533325', '兰坪白族普米族自治县', '533300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533400', '533400', '迪庆藏族自治州', '530000', '3', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533401', '533401', '香格里拉市', '533400', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533422', '533422', '德钦县', '533400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('533423', '533423', '维西傈僳族自治县', '533400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540000', '540000', '西藏自治区', '000000', '2', 26, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540100', '540100', '拉萨市', '540000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540102', '540102', '城关区', '540100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540103', '540103', '堆龙德庆区', '540100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540121', '540121', '林周县', '540100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540122', '540122', '当雄县', '540100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540123', '540123', '尼木县', '540100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540124', '540124', '曲水县', '540100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540126', '540126', '达孜县', '540100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540127', '540127', '墨竹工卡县', '540100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540200', '540200', '日喀则市', '540000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540202', '540202', '桑珠孜区', '540200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540221', '540221', '南木林县', '540200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540222', '540222', '江孜县', '540200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540223', '540223', '定日县', '540200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540224', '540224', '萨迦县', '540200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540225', '540225', '拉孜县', '540200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540226', '540226', '昂仁县', '540200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540227', '540227', '谢通门县', '540200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540228', '540228', '白朗县', '540200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540229', '540229', '仁布县', '540200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540230', '540230', '康马县', '540200', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540231', '540231', '定结县', '540200', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540232', '540232', '仲巴县', '540200', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540233', '540233', '亚东县', '540200', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540234', '540234', '吉隆县', '540200', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540235', '540235', '聂拉木县', '540200', '4', 16, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540236', '540236', '萨嘎县', '540200', '4', 17, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540237', '540237', '岗巴县', '540200', '4', 18, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540300', '540300', '昌都市', '540000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540302', '540302', '卡若区', '540300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540321', '540321', '江达县', '540300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540322', '540322', '贡觉县', '540300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540323', '540323', '类乌齐县', '540300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540324', '540324', '丁青县', '540300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540325', '540325', '察雅县', '540300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540326', '540326', '八宿县', '540300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540327', '540327', '左贡县', '540300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540328', '540328', '芒康县', '540300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540329', '540329', '洛隆县', '540300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540330', '540330', '边坝县', '540300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540400', '540400', '林芝市', '540000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540402', '540402', '巴宜区', '540400', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540421', '540421', '工布江达县', '540400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540422', '540422', '米林县', '540400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540423', '540423', '墨脱县', '540400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540424', '540424', '波密县', '540400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540425', '540425', '察隅县', '540400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540426', '540426', '朗县', '540400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540500', '540500', '山南市', '540000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540502', '540502', '乃东区', '540500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540521', '540521', '扎囊县', '540500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540522', '540522', '贡嘎县', '540500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540523', '540523', '桑日县', '540500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540524', '540524', '琼结县', '540500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540525', '540525', '曲松县', '540500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540526', '540526', '措美县', '540500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540527', '540527', '洛扎县', '540500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540528', '540528', '加查县', '540500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540529', '540529', '隆子县', '540500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540530', '540530', '错那县', '540500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('540531', '540531', '浪卡子县', '540500', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542400', '542400', '那曲地区', '540000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542421', '542421', '那曲县', '542400', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542422', '542422', '嘉黎县', '542400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542423', '542423', '比如县', '542400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542424', '542424', '聂荣县', '542400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542425', '542425', '安多县', '542400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542426', '542426', '申扎县', '542400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542427', '542427', '索县', '542400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542428', '542428', '班戈县', '542400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542429', '542429', '巴青县', '542400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542430', '542430', '尼玛县', '542400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542431', '542431', '双湖县', '542400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542500', '542500', '阿里地区', '540000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542521', '542521', '普兰县', '542500', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542522', '542522', '札达县', '542500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542523', '542523', '噶尔县', '542500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542524', '542524', '日土县', '542500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542525', '542525', '革吉县', '542500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542526', '542526', '改则县', '542500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('542527', '542527', '措勤县', '542500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610000', '610000', '陕西省', '000000', '2', 27, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610100', '610100', '西安市', '610000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610102', '610102', '新城区', '610100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610103', '610103', '碑林区', '610100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610104', '610104', '莲湖区', '610100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610111', '610111', '灞桥区', '610100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610112', '610112', '未央区', '610100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610113', '610113', '雁塔区', '610100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610114', '610114', '阎良区', '610100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610115', '610115', '临潼区', '610100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610116', '610116', '长安区', '610100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610117', '610117', '高陵区', '610100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610122', '610122', '蓝田县', '610100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610124', '610124', '周至县', '610100', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610125', '610125', '户县', '610100', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610200', '610200', '铜川市', '610000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610202', '610202', '王益区', '610200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610203', '610203', '印台区', '610200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610204', '610204', '耀州区', '610200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610222', '610222', '宜君县', '610200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610300', '610300', '宝鸡市', '610000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610302', '610302', '渭滨区', '610300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610303', '610303', '金台区', '610300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610304', '610304', '陈仓区', '610300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610322', '610322', '凤翔县', '610300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610323', '610323', '岐山县', '610300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610324', '610324', '扶风县', '610300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610326', '610326', '眉县', '610300', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610327', '610327', '陇县', '610300', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610328', '610328', '千阳县', '610300', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610329', '610329', '麟游县', '610300', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610330', '610330', '凤县', '610300', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610331', '610331', '太白县', '610300', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610400', '610400', '咸阳市', '610000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610402', '610402', '秦都区', '610400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610403', '610403', '杨陵区', '610400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610404', '610404', '渭城区', '610400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610422', '610422', '三原县', '610400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610423', '610423', '泾阳县', '610400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610424', '610424', '乾县', '610400', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610425', '610425', '礼泉县', '610400', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610426', '610426', '永寿县', '610400', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610427', '610427', '彬县', '610400', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610428', '610428', '长武县', '610400', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610429', '610429', '旬邑县', '610400', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610430', '610430', '淳化县', '610400', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610431', '610431', '武功县', '610400', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610481', '610481', '兴平市', '610400', '4', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610500', '610500', '渭南市', '610000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610502', '610502', '临渭区', '610500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610503', '610503', '华州区', '610500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610522', '610522', '潼关县', '610500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610523', '610523', '大荔县', '610500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610524', '610524', '合阳县', '610500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610525', '610525', '澄城县', '610500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610526', '610526', '蒲城县', '610500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610527', '610527', '白水县', '610500', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610528', '610528', '富平县', '610500', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610581', '610581', '韩城市', '610500', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610582', '610582', '华阴市', '610500', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610600', '610600', '延安市', '610000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610602', '610602', '宝塔区', '610600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610603', '610603', '安塞区', '610600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610621', '610621', '延长县', '610600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610622', '610622', '延川县', '610600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610623', '610623', '子长县', '610600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610625', '610625', '志丹县', '610600', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610626', '610626', '吴起县', '610600', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610627', '610627', '甘泉县', '610600', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610628', '610628', '富县', '610600', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610629', '610629', '洛川县', '610600', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610630', '610630', '宜川县', '610600', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610631', '610631', '黄龙县', '610600', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610632', '610632', '黄陵县', '610600', '4', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610700', '610700', '汉中市', '610000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610702', '610702', '汉台区', '610700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610721', '610721', '南郑县', '610700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610722', '610722', '城固县', '610700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610723', '610723', '洋县', '610700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610724', '610724', '西乡县', '610700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610725', '610725', '勉县', '610700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610726', '610726', '宁强县', '610700', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610727', '610727', '略阳县', '610700', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610728', '610728', '镇巴县', '610700', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610729', '610729', '留坝县', '610700', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610730', '610730', '佛坪县', '610700', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610800', '610800', '榆林市', '610000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610802', '610802', '榆阳区', '610800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610803', '610803', '横山区', '610800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610821', '610821', '神木县', '610800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610822', '610822', '府谷县', '610800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610824', '610824', '靖边县', '610800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610825', '610825', '定边县', '610800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610826', '610826', '绥德县', '610800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610827', '610827', '米脂县', '610800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610828', '610828', '佳县', '610800', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610829', '610829', '吴堡县', '610800', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610830', '610830', '清涧县', '610800', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610831', '610831', '子洲县', '610800', '4', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610900', '610900', '安康市', '610000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610902', '610902', '汉滨区', '610900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610921', '610921', '汉阴县', '610900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610922', '610922', '石泉县', '610900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610923', '610923', '宁陕县', '610900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610924', '610924', '紫阳县', '610900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610925', '610925', '岚皋县', '610900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610926', '610926', '平利县', '610900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610927', '610927', '镇坪县', '610900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610928', '610928', '旬阳县', '610900', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('610929', '610929', '白河县', '610900', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611000', '611000', '商洛市', '610000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611002', '611002', '商州区', '611000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611021', '611021', '洛南县', '611000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611022', '611022', '丹凤县', '611000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611023', '611023', '商南县', '611000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611024', '611024', '山阳县', '611000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611025', '611025', '镇安县', '611000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('611026', '611026', '柞水县', '611000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620000', '620000', '甘肃省', '000000', '2', 28, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620100', '620100', '兰州市', '620000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620102', '620102', '城关区', '620100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620103', '620103', '七里河区', '620100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620104', '620104', '西固区', '620100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620105', '620105', '安宁区', '620100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620111', '620111', '红古区', '620100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620121', '620121', '永登县', '620100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620122', '620122', '皋兰县', '620100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620123', '620123', '榆中县', '620100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620200', '620200', '嘉峪关市', '620000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620300', '620300', '金昌市', '620000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620302', '620302', '金川区', '620300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620321', '620321', '永昌县', '620300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620400', '620400', '白银市', '620000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620402', '620402', '白银区', '620400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620403', '620403', '平川区', '620400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620421', '620421', '靖远县', '620400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620422', '620422', '会宁县', '620400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620423', '620423', '景泰县', '620400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620500', '620500', '天水市', '620000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620502', '620502', '秦州区', '620500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620503', '620503', '麦积区', '620500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620521', '620521', '清水县', '620500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620522', '620522', '秦安县', '620500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620523', '620523', '甘谷县', '620500', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620524', '620524', '武山县', '620500', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620525', '620525', '张家川回族自治县', '620500', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620600', '620600', '武威市', '620000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620602', '620602', '凉州区', '620600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620621', '620621', '民勤县', '620600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620622', '620622', '古浪县', '620600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620623', '620623', '天祝藏族自治县', '620600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620700', '620700', '张掖市', '620000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620702', '620702', '甘州区', '620700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620721', '620721', '肃南裕固族自治县', '620700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620722', '620722', '民乐县', '620700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620723', '620723', '临泽县', '620700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620724', '620724', '高台县', '620700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620725', '620725', '山丹县', '620700', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620800', '620800', '平凉市', '620000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620802', '620802', '崆峒区', '620800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620821', '620821', '泾川县', '620800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620822', '620822', '灵台县', '620800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620823', '620823', '崇信县', '620800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620824', '620824', '华亭县', '620800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620825', '620825', '庄浪县', '620800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620826', '620826', '静宁县', '620800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620900', '620900', '酒泉市', '620000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620902', '620902', '肃州区', '620900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620921', '620921', '金塔县', '620900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620922', '620922', '瓜州县', '620900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620923', '620923', '肃北蒙古族自治县', '620900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620924', '620924', '阿克塞哈萨克族自治县', '620900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620981', '620981', '玉门市', '620900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('620982', '620982', '敦煌市', '620900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621000', '621000', '庆阳市', '620000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621002', '621002', '西峰区', '621000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621021', '621021', '庆城县', '621000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621022', '621022', '环县', '621000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621023', '621023', '华池县', '621000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621024', '621024', '合水县', '621000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621025', '621025', '正宁县', '621000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621026', '621026', '宁县', '621000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621027', '621027', '镇原县', '621000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621100', '621100', '定西市', '620000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621102', '621102', '安定区', '621100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621121', '621121', '通渭县', '621100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621122', '621122', '陇西县', '621100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621123', '621123', '渭源县', '621100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621124', '621124', '临洮县', '621100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621125', '621125', '漳县', '621100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621126', '621126', '岷县', '621100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621200', '621200', '陇南市', '620000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621202', '621202', '武都区', '621200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621221', '621221', '成县', '621200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621222', '621222', '文县', '621200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621223', '621223', '宕昌县', '621200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621224', '621224', '康县', '621200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621225', '621225', '西和县', '621200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621226', '621226', '礼县', '621200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621227', '621227', '徽县', '621200', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('621228', '621228', '两当县', '621200', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622900', '622900', '临夏回族自治州', '620000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622901', '622901', '临夏市', '622900', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622921', '622921', '临夏县', '622900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622922', '622922', '康乐县', '622900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622923', '622923', '永靖县', '622900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622924', '622924', '广河县', '622900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622925', '622925', '和政县', '622900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622926', '622926', '东乡族自治县', '622900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('622927', '622927', '积石山保安族东乡族撒拉族自治县', '622900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623000', '623000', '甘南藏族自治州', '620000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623001', '623001', '合作市', '623000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623021', '623021', '临潭县', '623000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623022', '623022', '卓尼县', '623000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623023', '623023', '舟曲县', '623000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623024', '623024', '迭部县', '623000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623025', '623025', '玛曲县', '623000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623026', '623026', '碌曲县', '623000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('623027', '623027', '夏河县', '623000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630000', '630000', '青海省', '000000', '2', 29, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630100', '630100', '西宁市', '630000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630102', '630102', '城东区', '630100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630103', '630103', '城中区', '630100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630104', '630104', '城西区', '630100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630105', '630105', '城北区', '630100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630121', '630121', '大通回族土族自治县', '630100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630122', '630122', '湟中县', '630100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630123', '630123', '湟源县', '630100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630200', '630200', '海东市', '630000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630202', '630202', '乐都区', '630200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630203', '630203', '平安区', '630200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630222', '630222', '民和回族土族自治县', '630200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630223', '630223', '互助土族自治县', '630200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630224', '630224', '化隆回族自治县', '630200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('630225', '630225', '循化撒拉族自治县', '630200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632200', '632200', '海北藏族自治州', '630000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632221', '632221', '门源回族自治县', '632200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632222', '632222', '祁连县', '632200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632223', '632223', '海晏县', '632200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632224', '632224', '刚察县', '632200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632300', '632300', '黄南藏族自治州', '630000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632321', '632321', '同仁县', '632300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632322', '632322', '尖扎县', '632300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632323', '632323', '泽库县', '632300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632324', '632324', '河南蒙古族自治县', '632300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632500', '632500', '海南藏族自治州', '630000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632521', '632521', '共和县', '632500', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632522', '632522', '同德县', '632500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632523', '632523', '贵德县', '632500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632524', '632524', '兴海县', '632500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632525', '632525', '贵南县', '632500', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632600', '632600', '果洛藏族自治州', '630000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632621', '632621', '玛沁县', '632600', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632622', '632622', '班玛县', '632600', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632623', '632623', '甘德县', '632600', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632624', '632624', '达日县', '632600', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632625', '632625', '久治县', '632600', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632626', '632626', '玛多县', '632600', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632700', '632700', '玉树藏族自治州', '630000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632701', '632701', '玉树市', '632700', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632722', '632722', '杂多县', '632700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632723', '632723', '称多县', '632700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632724', '632724', '治多县', '632700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632725', '632725', '囊谦县', '632700', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632726', '632726', '曲麻莱县', '632700', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632800', '632800', '海西蒙古族藏族自治州', '630000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632801', '632801', '格尔木市', '632800', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632802', '632802', '德令哈市', '632800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632821', '632821', '乌兰县', '632800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632822', '632822', '都兰县', '632800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('632823', '632823', '天峻县', '632800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640000', '640000', '宁夏回族自治区', '000000', '2', 30, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640100', '640100', '银川市', '640000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640104', '640104', '兴庆区', '640100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640105', '640105', '西夏区', '640100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640106', '640106', '金凤区', '640100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640121', '640121', '永宁县', '640100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640122', '640122', '贺兰县', '640100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640181', '640181', '灵武市', '640100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640200', '640200', '石嘴山市', '640000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640202', '640202', '大武口区', '640200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640205', '640205', '惠农区', '640200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640221', '640221', '平罗县', '640200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640300', '640300', '吴忠市', '640000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640302', '640302', '利通区', '640300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640303', '640303', '红寺堡区', '640300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640323', '640323', '盐池县', '640300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640324', '640324', '同心县', '640300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640381', '640381', '青铜峡市', '640300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640400', '640400', '固原市', '640000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640402', '640402', '原州区', '640400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640422', '640422', '西吉县', '640400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640423', '640423', '隆德县', '640400', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640424', '640424', '泾源县', '640400', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640425', '640425', '彭阳县', '640400', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640500', '640500', '中卫市', '640000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640502', '640502', '沙坡头区', '640500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640521', '640521', '中宁县', '640500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('640522', '640522', '海原县', '640500', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650000', '650000', '新疆维吾尔自治区', '000000', '2', 31, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650100', '650100', '乌鲁木齐市', '650000', '3', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650102', '650102', '天山区', '650100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650103', '650103', '沙依巴克区', '650100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650104', '650104', '新市区', '650100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650105', '650105', '水磨沟区', '650100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650106', '650106', '头屯河区', '650100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650107', '650107', '达坂城区', '650100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650109', '650109', '米东区', '650100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650121', '650121', '乌鲁木齐县', '650100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650200', '650200', '克拉玛依市', '650000', '3', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650202', '650202', '独山子区', '650200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650203', '650203', '克拉玛依区', '650200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650204', '650204', '白碱滩区', '650200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650205', '650205', '乌尔禾区', '650200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650400', '650400', '吐鲁番市', '650000', '3', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650402', '650402', '高昌区', '650400', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650421', '650421', '鄯善县', '650400', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650422', '650422', '托克逊县', '650400', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650500', '650500', '哈密市', '650000', '3', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650502', '650502', '伊州区', '650500', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650521', '650521', '巴里坤哈萨克自治县', '650500', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('650522', '650522', '伊吾县', '650500', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652300', '652300', '昌吉回族自治州', '650000', '3', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652301', '652301', '昌吉市', '652300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652302', '652302', '阜康市', '652300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652323', '652323', '呼图壁县', '652300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652324', '652324', '玛纳斯县', '652300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652325', '652325', '奇台县', '652300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652327', '652327', '吉木萨尔县', '652300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652328', '652328', '木垒哈萨克自治县', '652300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652700', '652700', '博尔塔拉蒙古自治州', '650000', '3', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652701', '652701', '博乐市', '652700', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652702', '652702', '阿拉山口市', '652700', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652722', '652722', '精河县', '652700', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652723', '652723', '温泉县', '652700', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652800', '652800', '巴音郭楞蒙古自治州', '650000', '3', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652801', '652801', '库尔勒市', '652800', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652822', '652822', '轮台县', '652800', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652823', '652823', '尉犁县', '652800', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652824', '652824', '若羌县', '652800', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652825', '652825', '且末县', '652800', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652826', '652826', '焉耆回族自治县', '652800', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652827', '652827', '和静县', '652800', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652828', '652828', '和硕县', '652800', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652829', '652829', '博湖县', '652800', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652900', '652900', '阿克苏地区', '650000', '3', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652901', '652901', '阿克苏市', '652900', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652922', '652922', '温宿县', '652900', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652923', '652923', '库车县', '652900', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652924', '652924', '沙雅县', '652900', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652925', '652925', '新和县', '652900', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652926', '652926', '拜城县', '652900', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652927', '652927', '乌什县', '652900', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652928', '652928', '阿瓦提县', '652900', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('652929', '652929', '柯坪县', '652900', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653000', '653000', '克孜勒苏柯尔克孜自治州', '650000', '3', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653001', '653001', '阿图什市', '653000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653022', '653022', '阿克陶县', '653000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653023', '653023', '阿合奇县', '653000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653024', '653024', '乌恰县', '653000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653100', '653100', '喀什地区', '650000', '3', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653101', '653101', '喀什市', '653100', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653121', '653121', '疏附县', '653100', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653122', '653122', '疏勒县', '653100', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653123', '653123', '英吉沙县', '653100', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653124', '653124', '泽普县', '653100', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653125', '653125', '莎车县', '653100', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653126', '653126', '叶城县', '653100', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653127', '653127', '麦盖提县', '653100', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653128', '653128', '岳普湖县', '653100', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653129', '653129', '伽师县', '653100', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653130', '653130', '巴楚县', '653100', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653131', '653131', '塔什库尔干塔吉克自治县', '653100', '4', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653200', '653200', '和田地区', '650000', '3', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653201', '653201', '和田市', '653200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653221', '653221', '和田县', '653200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653222', '653222', '墨玉县', '653200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653223', '653223', '皮山县', '653200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653224', '653224', '洛浦县', '653200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653225', '653225', '策勒县', '653200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653226', '653226', '于田县', '653200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('653227', '653227', '民丰县', '653200', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654000', '654000', '伊犁哈萨克自治州', '650000', '3', 12, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654002', '654002', '伊宁市', '654000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654003', '654003', '奎屯市', '654000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654004', '654004', '霍尔果斯市', '654000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654021', '654021', '伊宁县', '654000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654022', '654022', '察布查尔锡伯自治县', '654000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654023', '654023', '霍城县', '654000', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654024', '654024', '巩留县', '654000', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654025', '654025', '新源县', '654000', '4', 8, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654026', '654026', '昭苏县', '654000', '4', 9, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654027', '654027', '特克斯县', '654000', '4', 10, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654028', '654028', '尼勒克县', '654000', '4', 11, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654200', '654200', '塔城地区', '650000', '3', 13, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654201', '654201', '塔城市', '654200', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654202', '654202', '乌苏市', '654200', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654221', '654221', '额敏县', '654200', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654223', '654223', '沙湾县', '654200', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654224', '654224', '托里县', '654200', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654225', '654225', '裕民县', '654200', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654226', '654226', '和布克赛尔蒙古自治县', '654200', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654300', '654300', '阿勒泰地区', '650000', '3', 14, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654301', '654301', '阿勒泰市', '654300', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654321', '654321', '布尔津县', '654300', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654322', '654322', '富蕴县', '654300', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654323', '654323', '福海县', '654300', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654324', '654324', '哈巴河县', '654300', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654325', '654325', '青河县', '654300', '4', 6, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('654326', '654326', '吉木乃县', '654300', '4', 7, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('659000', '659000', '自治区直辖县级行政区划', '650000', '3', 15, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('659001', '659001', '石河子市', '659000', '4', 1, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('659002', '659002', '阿拉尔市', '659000', '4', 2, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('659003', '659003', '图木舒克市', '659000', '4', 3, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('659004', '659004', '五家渠市', '659000', '4', 4, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('659006', '659006', '铁门关市', '659000', '4', 5, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('710000', '710000', '台湾省', '000000', '2', 32, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('810000', '810000', '香港特别行政区', '000000', '2', 33, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');
INSERT INTO `jy_region_tab` VALUES ('820000', '820000', '澳门特别行政区', '000000', '2', 34, NULL, NULL, NULL, NULL, NULL, '2017-11-13 09:31:27', NULL, '2017-11-13 09:31:27');

-- ----------------------------
-- Table structure for jy_resource_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_resource_tab`;
CREATE TABLE `jy_resource_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `resource_name` varchar(255)  NULL DEFAULT NULL COMMENT '资源名称',
  `url` varchar(255)  NULL DEFAULT NULL COMMENT '资源路径',
  `permission_id` varchar(32)  NULL DEFAULT NULL,
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Table structure for jy_role_permission_relation_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_role_permission_relation_tab`;
CREATE TABLE `jy_role_permission_relation_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `role_id` varchar(32)  NULL DEFAULT NULL COMMENT '角色ID',
  `permission_id` varchar(32)  NULL DEFAULT NULL COMMENT '权限ID',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_role_permission_relation_tab
-- ----------------------------
INSERT INTO `jy_role_permission_relation_tab` VALUES ('07f0be88e02e475986531c2255446a93', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d121', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('0bfe4b54bbdf4c58b26f694b8a4d9755', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d119', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('0f5bfb4ec5eb449fbc5c760d354602e1', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e822b120', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('19519520f0a54354b117a69dd4b01f48', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e8b8b123', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('1efed89639a24068b8f49c21748da8e6', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d120', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('2bd298e1d9b64d68a3bc4cf6718a5915', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e820b120', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('511cbfc8f0b8445d9a25d2a9338cd6dd', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d114', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('5f0e0698e9934b88bf790b78a3e46fd5', '67a2df17321a4c3994a54c7ef22839b1', '4aad35f1de154de281df3f916875d114', '1', '2017-12-11 15:04:16', '1', '2017-12-11 15:04:16');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('5fb47a52f6fd4997b21b395704056601', '2fb89e09a25b42f28f6a93edb92ddd7f', 'bab83e402b004ef2bd6f57428ce3d84d', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('63a2f68376d047a1b03a129bf4784cdb', '2fb89e09a25b42f28f6a93edb92ddd7f', '6cc537968d6a42469266b78889b40919', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('754a771934a64201a8cfabd40c5a4bd1', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d117', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('7f92ec3d7c2e43a0bd1ca5bde864e828', '67a2df17321a4c3994a54c7ef22839b1', '4aad35f1de154de281df3f916875d119', '1', '2017-12-11 15:04:16', '1', '2017-12-11 15:04:16');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('87e166a6f17e43abaa3c089ede0dbe9b', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d115', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('9c79efc0efe8453bb76c8611e5e791fe', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d113', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('a156716f0c424f209f22a18b44911a2b', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d118', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('a66d5712bed54f318979a56eb4435d69', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e8b8b120', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('a9cdc5f3ac0642e7a86a7352e23a7f94', '2fb89e09a25b42f28f6a93edb92ddd7f', '8a1edc19adc94f99852912cbf06d71a1', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('b0155b761f574c50bc68000ea300bd8b', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e821b121', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('b4fc478285094222b2f33836e1b9492c', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e8b8b121', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('beaa7a0fa7b34af7af7624f1bc6a2a87', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d116', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('c0081a4bfbd04b55b626e1047a42aa30', '2fb89e09a25b42f28f6a93edb92ddd7f', 'a21aa9b21b244350865bdae31f06d4c7', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('d4df08558d2e4e6caf8fc77f23872d70', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d122', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('d4df08558d2e4e6caf8fc77f23872d74', '2fb89e09a25b42f28f6a93edb92ddd7f', '4aad35f1de154de281df3f916875d123', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('dd55c4f883704ba087984797866a5cad', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e823b121', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('e2e73b8e4f054dd1a251350f97e0891b', '2fb89e09a25b42f28f6a93edb92ddd7f', 'bab83e402b004ef2bd6f57428ce3d000', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('e2e73b8e4f054dd1a251350f97e0891v', '2fb89e09a25b42f28f6a93edb92ddd7f', '9dbf0e94ccdb44d7a2e5c434e8b8b122', '1', '2017-10-27 14:10:11', '1', '2017-10-27 14:10:11');
INSERT INTO `jy_role_permission_relation_tab` VALUES ('eb3444fbb89b4e04ab48e2cfa72d23b1', '67a2df17321a4c3994a54c7ef22839b1', '4aad35f1de154de281df3f916875d115', '1', '2017-12-11 15:04:16', '1', '2017-12-11 15:04:16');

-- ----------------------------
-- Table structure for jy_role_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_role_tab`;
CREATE TABLE `jy_role_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `role_name` varchar(100)  NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '逻辑删除',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_role_tab
-- ----------------------------
INSERT INTO `jy_role_tab` VALUES ('2fb89e09a25b42f28f6a93edb92ddd7f', '系统管理员', '', 0, NULL, NULL, NULL, NULL);
INSERT INTO `jy_role_tab` VALUES ('67a2df17321a4c3994a54c7ef22839b1', '用户', 'test', 0, '1', '2017-12-07 19:32:48', '1', '2017-12-07 19:32:48');

-- ----------------------------
-- Table structure for jy_system_config_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_system_config_tab`;
CREATE TABLE `jy_system_config_tab`  (
  `sys_key` varchar(255)  NOT NULL,
  `sys_value` varchar(255)  NULL DEFAULT NULL,
  PRIMARY KEY (`sys_key`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_system_config_tab
-- ----------------------------
INSERT INTO `jy_system_config_tab` VALUES ('detection_vender', 'JF');
INSERT INTO `jy_system_config_tab` VALUES ('last_check_time', '2018-01-31 11:01:33');
INSERT INTO `jy_system_config_tab` VALUES ('organization_id', '0fae7da3605b4bd687f1f97be25e289e');
INSERT INTO `jy_system_config_tab` VALUES ('organization_id市', 'd59b66b71460446f99c00bc1aac1d03b');
INSERT INTO `jy_system_config_tab` VALUES ('organization_ip', '192.168.128.231');
INSERT INTO `jy_system_config_tab` VALUES ('shield_vender', 'JF');

-- ----------------------------
-- Table structure for jy_system_log_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_system_log_tab`;
CREATE TABLE `jy_system_log_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `operation_event` varchar(255)  NOT NULL COMMENT '操作事件',
  `operation_user` varchar(32)  NOT NULL COMMENT '操作用户id',
  `operation_ip` varchar(15)  NOT NULL COMMENT '操作用户ip',
  `operation_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `operation_type` tinyint(1) NOT NULL COMMENT '操作类型--0增、1删、2改、3：授权',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构id',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_system_log_tab
-- ----------------------------
INSERT INTO `jy_system_log_tab` VALUES ('16721bb916d2469f81e6b636b20ccc5e', '新增考试计划', '1', '0:0:0:0:0:0:0:1', '2018-05-03 10:31:27', 0, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-03 10:31:27', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('38a1ce67ae8743b59b1c276c65061b2e', '删除设备信息', '1', '0:0:0:0:0:0:0:1', '2018-05-18 10:01:30', 1, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-18 10:01:30', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('48024c35e6ea4649adbf89f24df4fcef', '删除设备信息', '1', '0:0:0:0:0:0:0:1', '2018-05-18 10:01:34', 1, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-18 10:01:34', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('4e58f6cd354d4df29d915c6343fd0383', '新增考试类型', '1', '0:0:0:0:0:0:0:1', '2018-05-02 14:30:56', 0, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-02 14:30:56', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('67639398bf374fc381c4c9ef93a57b13', '新增考试场次', '1', '127.0.0.1', '2018-05-17 10:55:12', 0, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-17 10:55:12', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('72d789237fee4973b225e342ea941372', '新增考试计划', '1', '0:0:0:0:0:0:0:1', '2018-05-02 14:31:25', 0, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-02 14:31:25', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('a7063e9b447349f2be857ebf3b1250b1', '修改考试计划', '1', '127.0.0.1', '2018-05-17 10:55:37', 2, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-17 10:55:37', NULL, NULL);
INSERT INTO `jy_system_log_tab` VALUES ('b9a50b1ace7243d4825dcc5a9f96fc9c', '新增考试计划', '1', '127.0.0.1', '2018-05-17 10:54:17', 0, '787fc1be09c74f2cbc0e3cffa4b075f0', '1', '2018-05-17 10:54:17', NULL, NULL);

-- ----------------------------
-- Table structure for jy_user_tab
-- ----------------------------
DROP TABLE IF EXISTS `jy_user_tab`;
CREATE TABLE `jy_user_tab`  (
  `id` varchar(32)  NOT NULL COMMENT '32位uuid',
  `name` varchar(100)  NULL DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别--0：未知、1：男、2：女',
  `age` tinyint(3) NULL DEFAULT NULL COMMENT '年龄',
  `email` varchar(100)  NULL DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(12)  NULL DEFAULT NULL COMMENT '电话号码',
  `mobile` varchar(11)  NULL DEFAULT NULL COMMENT '手机号码',
  `user_name` varchar(100)  NOT NULL COMMENT '登录名称',
  `password` varchar(32)  NOT NULL COMMENT '密码',
  `province_code` varchar(10)  NULL DEFAULT NULL COMMENT '省',
  `city_code` varchar(10)  NULL DEFAULT NULL COMMENT '市',
  `region_code` varchar(10)  NULL DEFAULT NULL COMMENT '区',
  `address` varchar(255)  NULL DEFAULT NULL COMMENT '地址',
  `image` varchar(255)  NULL DEFAULT NULL COMMENT '头像图片地址',
  `role_id` varchar(32)  NULL DEFAULT NULL COMMENT '角色ID',
  `data_permission` tinyint(1) NULL DEFAULT NULL COMMENT '数据权限--0：个人、1、所属机构、2：所有管理机构、3：所属机构',
  `org_id` varchar(32)  NULL DEFAULT NULL COMMENT '组织机构id',
  `create_user` varchar(50)  NULL DEFAULT NULL COMMENT '创建用户',
  `create_date` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(50)  NULL DEFAULT NULL COMMENT '更新用户',
  `update_date` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0,
  `remark` varchar(255)  NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) 
) ENGINE = InnoDB;

-- ----------------------------
-- Records of jy_user_tab
-- ----------------------------
INSERT INTO `jy_user_tab` VALUES ('1', '管理员', 1, 18, '711@sina.com', '13511111111', '13511111111', 'goldsun', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, '苏州园区', NULL, '2fb89e09a25b42f28f6a93edb92ddd7f', NULL, '787fc1be09c74f2cbc0e3cffa4b075f0', NULL, '2017-12-04 10:47:16', '1', '2018-03-12 16:21:35', 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;
