/*
 Navicat MySQL Data Transfer

 Source Server         : al-db
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : 192.168.0.20:3307
 Source Schema         : al_db

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 24/02/2021 16:05:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'chinese food');

-- ----------------------------
-- Table structure for ingredient
-- ----------------------------
DROP TABLE IF EXISTS `ingredient`;
CREATE TABLE `ingredient`  (
  `ingredient_id` int(11) NOT NULL,
  `ingredient_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `calorie_per_100g` int(11) NULL DEFAULT NULL,
  `ingredient_image` mediumblob NULL,
  PRIMARY KEY (`ingredient_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingredient
-- ----------------------------
INSERT INTO `ingredient` VALUES (1, 'tomate', 18, NULL);
INSERT INTO `ingredient` VALUES (2, 'egg', 147, NULL);

-- ----------------------------
-- Table structure for ingredient_nutrition
-- ----------------------------
DROP TABLE IF EXISTS `ingredient_nutrition`;
CREATE TABLE `ingredient_nutrition`  (
  `ingredient_id` int(11) NOT NULL,
  `nutrition_id` int(11) NOT NULL,
  `amount_per_100g` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ingredient_id`, `nutrition_id`) USING BTREE,
  INDEX `nutrition_id`(`nutrition_id`) USING BTREE,
  CONSTRAINT `ingredient_nutrition_ibfk_1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ingredient_nutrition_ibfk_2` FOREIGN KEY (`nutrition_id`) REFERENCES `nutrition` (`nutrition_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ingredient_nutrition
-- ----------------------------
INSERT INTO `ingredient_nutrition` VALUES (1, 1, 0);
INSERT INTO `ingredient_nutrition` VALUES (2, 1, 13);

-- ----------------------------
-- Table structure for meal_cart
-- ----------------------------
DROP TABLE IF EXISTS `meal_cart`;
CREATE TABLE `meal_cart`  (
  `meal_cart_id` int(11) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`meal_cart_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_cart
-- ----------------------------
INSERT INTO `meal_cart` VALUES (1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for meal_cart_recipe
-- ----------------------------
DROP TABLE IF EXISTS `meal_cart_recipe`;
CREATE TABLE `meal_cart_recipe`  (
  `meal_cart_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`meal_cart_id`, `recipe_id`) USING BTREE,
  INDEX `recipe_id`(`recipe_id`) USING BTREE,
  CONSTRAINT `meal_cart_recipe_ibfk_1` FOREIGN KEY (`meal_cart_id`) REFERENCES `meal_cart` (`meal_cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `meal_cart_recipe_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_cart_recipe
-- ----------------------------
INSERT INTO `meal_cart_recipe` VALUES (1, 0);
INSERT INTO `meal_cart_recipe` VALUES (1, 1);

-- ----------------------------
-- Table structure for nutrition
-- ----------------------------
DROP TABLE IF EXISTS `nutrition`;
CREATE TABLE `nutrition`  (
  `nutrition_id` int(11) NOT NULL,
  `nutrition_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`nutrition_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nutrition
-- ----------------------------
INSERT INTO `nutrition` VALUES (1, 'protein');

-- ----------------------------
-- Table structure for recipe
-- ----------------------------
DROP TABLE IF EXISTS `recipe`;
CREATE TABLE `recipe`  (
  `recipe_id` int(11) NOT NULL,
  `recipe_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `recipe_description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `prep_time` int(11) NULL DEFAULT NULL,
  `cook_time` int(11) NULL DEFAULT NULL,
  `recipe_subtitle` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `main_image` mediumblob NULL,
  `sub_image` mediumblob NULL,
  `calorie_per_100g` int(11) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`recipe_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recipe
-- ----------------------------
INSERT INTO `recipe` VALUES (0, 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `recipe` VALUES (1, 'Stir-fried tomato with egg', NULL, 5, 10, NULL, NULL, NULL, 74, NULL, NULL);

-- ----------------------------
-- Table structure for recipe_category
-- ----------------------------
DROP TABLE IF EXISTS `recipe_category`;
CREATE TABLE `recipe_category`  (
  `recipe_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`recipe_id`, `category_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  CONSTRAINT `recipe_category_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipe_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recipe_category
-- ----------------------------
INSERT INTO `recipe_category` VALUES (1, 1);

-- ----------------------------
-- Table structure for recipe_ingredient
-- ----------------------------
DROP TABLE IF EXISTS `recipe_ingredient`;
CREATE TABLE `recipe_ingredient`  (
  `recipe_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity_g` int(11) NOT NULL,
  PRIMARY KEY (`recipe_id`, `ingredient_id`) USING BTREE,
  INDEX `ingredient_id`(`ingredient_id`) USING BTREE,
  CONSTRAINT `recipe_ingredient_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipe_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recipe_ingredient
-- ----------------------------
INSERT INTO `recipe_ingredient` VALUES (1, 1, 300);
INSERT INTO `recipe_ingredient` VALUES (1, 2, 150);

-- ----------------------------
-- Table structure for testImage
-- ----------------------------
DROP TABLE IF EXISTS `testImage`;
CREATE TABLE `testImage`  (
  `image` mediumblob NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for testTable
-- ----------------------------
DROP TABLE IF EXISTS `testTable`;
CREATE TABLE `testTable`  (
  `testId` int(11) NOT NULL,
  `testName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`testId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of testTable
-- ----------------------------
INSERT INTO `testTable` VALUES (1, 'test1');
INSERT INTO `testTable` VALUES (2, 'test2');

SET FOREIGN_KEY_CHECKS = 1;
