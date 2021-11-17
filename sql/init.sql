
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for vicerp_jobs
-- ----------------------------
DROP TABLE IF EXISTS `vicerp_timedReward`;
CREATE TABLE `vicerp_timedReward`  (
  `id` int NOT NULL,
  `last_login` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_logoff` datetime NULL DEFAULT NULL,
  `played_time` int NOT NULL DEFAULT 0,
  `reward_state` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `vrp_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
