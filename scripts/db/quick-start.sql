-- 创建数据库
DROP DATABASE IF EXISTS dgutoj;

CREATE DATABASE dgutoj DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

-- 使用数据库
USE dgutoj;

-- 创建具有完全权限的用户
CREATE USER IF NOT EXISTS 'dgutoj_admin' @'%' IDENTIFIED BY 'Dg#9K$mP2vL8nX4@2025';

GRANT ALL PRIVILEGES ON dgutoj.* TO 'dgutoj_admin' @'%';

-- 创建具有增删改查权限(除删除外)的用户
CREATE USER IF NOT EXISTS 'dgutoj_reader' @'%' IDENTIFIED BY 'Rj#5H$kL9pQ2mN7@2025';

GRANT SELECT, INSERT , UPDATE ON dgutoj.* TO 'dgutoj_reader' @'%';

-- 刷新权限
FLUSH PRIVILEGES;

-- 创建题目表
CREATE TABLE IF NOT EXISTS `problem` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '题目 ID',
    `title` VARCHAR(50) NOT NULL COMMENT '题目名称',
    `time_limit` INT NOT NULL DEFAULT 1000 COMMENT '时间限制，单位毫秒，默认：1000ms',
    `memory_limit` INT NOT NULL DEFAULT 256 COMMENT '内存限制，单位 MB，默认：256MB',
    `created_by` VARCHAR(50) NOT NULL DEFAULT '佚名' COMMENT '题目来源，默认：佚名',
    `enabled` TINYINT NOT NULL DEFAULT 1 COMMENT '题目是否可用，1：可用，0：不可用，默认：1',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '题目表';

-- 创建比赛表
CREATE TABLE IF NOT EXISTS `contest` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '比赛 ID',
    `title` VARCHAR(50) NOT NULL COMMENT '比赛名称',
    `start_time` DATETIME NOT NULL COMMENT '比赛开始时间',
    `end_time` DATETIME NOT NULL COMMENT '比赛结束时间',
    `duration` INT NOT NULL DEFAULT 300 COMMENT '比赛持续时间，单位分钟，默认：5 小时',
    `problem_ids` JSON NOT NULL COMMENT '题目 ID 列表',
    `password` CHAR(8) NOT NULL DEFAULT '' COMMENT '比赛题目包解压密码，若为空则无密码，默认：空',
    `created_by` VARCHAR(50) NOT NULL DEFAULT '佚名' COMMENT '比赛发起人，默认：佚名',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX `idx_start_time` (`start_time` ASC)
)

