DROP DATABASE IF EXISTS db_convenientbuy;
CREATE DATABASE db_convenientbuy;

DROP TABLE IF EXISTS db_convenientbuy.cb_content;
CREATE TABLE db_convenientbuy.cb_content (
  id          BIGINT(20)   AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK ID',
  category_id BIGINT(20) NOT NULL
  COMMENT '类别 ID',
  title       VARCHAR(200) DEFAULT NULL
  COMMENT '标题',
  sub_title   VARCHAR(100) DEFAULT NULL
  COMMENT '子标题',
  title_desc  VARCHAR(500) DEFAULT NULL
  COMMENT '标题描述',
  url         VARCHAR(300) DEFAULT NULL
  COMMENT '链接',
  pic         VARCHAR(400) DEFAULT NULL
  COMMENT '图片1绝对路径',
  pic2        VARCHAR(400) DEFAULT NULL
  COMMENT '图片2绝对路径',
  content     DATETIME     DEFAULT NULL
  COMMENT '内容',
  created     DATETIME     DEFAULT NULL
  COMMENT '创建时间',
  updated     DATETIME     DEFAULT NULL
  COMMENT '更新时间',
  KEY category_id(category_id),
  KEY updated(updated)
)
  COMMENT '首页展示图';


DROP TABLE IF EXISTS db_convenientbuy.cb_content_category;
CREATE TABLE db_convenientbuy.cb_content_category (
  id         BIGINT(20)  AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK ID',
  parent_id  BIGINT(20)  DEFAULT NULL
  COMMENT '父类 ID=0，代表一级',
  name       VARCHAR(50) DEFAULT NULL
  COMMENT '类别名称',
  status     INT(1)      DEFAULT '1'
  COMMENT '状态，1正常/2删除',
  sort_order INT(4)      DEFAULT NULL
  COMMENT '排序，同级类别展示次序。',
  is_parent  TINYINT(1)  DEFAULT '1'
  COMMENT '1 true/ 2false',
  created    DATETIME    DEFAULT NULL
  COMMENT '创建时间',
  updated    DATETIME    DEFAULT NULL
  COMMENT '更新时间',
  KEY parent_id (parent_id, status) USING BTREE,
  KEY sort_order(sort_order)
)
  COMMENT 'CMS - 类目分类表';

DROP TABLE IF EXISTS db_convenientbuy.cb_item;
CREATE TABLE db_convenientbuy.cb_item (
  id         BIGINT(20)            AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK ID',
  title      VARCHAR(100) NOT NULL
  COMMENT '商品标题',
  sell_point VARCHAR(500)          DEFAULT NULL
  COMMENT '商品卖点',
  price      BIGINT(20)   NOT NULL
  COMMENT '商家价格，单位 分',
  num        INT(10)      NOT NULL
  COMMENT '库存数量',
  barcode    VARCHAR(30)           DEFAULT NULL
  COMMENT '条形码',
  image      VARCHAR(500)          DEFAULT NULL
  COMMENT '图片',
  cid        BIGINT(10)   NOT NULL
  COMMENT '类别 ID',
  status     TINYINT(4)   NOT NULL DEFAULT '1'
  COMMENT '状态 1正常/2下架/3删除',
  created    DATETIME              DEFAULT NULL
  COMMENT '创建时间',
  updated    DATETIME              DEFAULT NULL
  COMMENT '更新时间',
  KEY cid(cid),
  KEY status(status),
  KEY updated(updated)
)
  COMMENT '';

DROP TABLE IF EXISTS db_convenientbuy.cb_item_cat;
CREATE TABLE db_convenientbuy.cb_item_cat (
  id         BIGINT(20)  AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK ID',
  prient_id  BIGINT(20)  DEFAULT NULL
  COMMENT '父类 id=0,代表一级类别',
  name       VARCHAR(50) DEFAULT NULL
  COMMENT '类别名称',
  status     INT(1)      DEFAULT '1'
  COMMENT '状态 1正常/2删除',
  sort_order INT(4)      DEFAULT '1'
  COMMENT '排列顺序',
  is_parent  TINYINT(1)  DEFAULT '1'
  COMMENT '是否为父类级别 1true/2false',
  created    DATETIME    DEFAULT NULL
  COMMENT '创建时间',
  updated    DATETIME    DEFAULT NULL
  COMMENT '更新时间',
  KEY parent_id(prient_id) USING BTREE,
  KEY sort_order(sort_order)
)
  COMMENT '商品类别';

DROP TABLE IF EXISTS db_convenientbuy.cb_item_decs;
CREATE TABLE db_convenientbuy.cb_item_desc (
  item_id   BIGINT(20) AUTO_INCREMENT PRIMARY KEY
  COMMENT ' PK 商品 ID',
  item_desc TEXT COMMENT '商品描述',
  created   DATETIME   DEFAULT NULL
  COMMENT '创建时间',
  updated   DATETIME   DEFAULT NULL
  COMMENT '更新时间'
)
  COMMENT '商品描述表';

DROP TABLE IF EXISTS db_convenientbuy.cb_item_parm;
CREATE TABLE db_convenientbuy.cb_item_parm (
  id          BIGINT(20) AUTO_INCREMENT PRIMARY KEY
  COMMENT 'PK ID',
  item_cat_id BIGINT(20) DEFAULT NULL
  COMMENT '商品类别 ID',
  parm_data   TEXT COMMENT '商品参数,json 格式',
  created     DATETIME   DEFAULT NULL
  COMMENT '创建时间',
  updated     DATETIME   DEFAULT NULL
  COMMENT '更新时间',
  KEY item_cat_id(item_cat_id)
)
  COMMENT '商品规格参数';

DROP TABLE IF EXISTS db_convenientbuy.cb_item_parm_item;
CREATE TABLE db_convenientbuy.cb_item_parm_item (
  id         BIGINT(20) AUTO_INCREMENT PRIMARY KEY
  COMMENT '',
  item_id    BIGINT(20) DEFAULT NULL
  COMMENT '',
  param_data TEXT COMMENT '参数数据，格式为json格式',
  created    DATETIME   DEFAULT NULL
  COMMENT '创建时间',
  updated    DATETIME   DEFAULT NULL
  COMMENT '更新时间',
  KEY item_id(item_id) USING BTREE
)
  COMMENT '商品规格和商品关系表';

DROP TABLE IF EXISTS db_convenientbuy.cb_orde;
CREATE TABLE db_convenientbuy.cb_orde (
  order_id      VARCHAR(50)
                COLLATE utf8_bin PRIMARY KEY DEFAULT NULL
  COMMENT '',
  payment       VARCHAR(50)
                COLLATE utf8_bin             DEFAULT NULL
  COMMENT '',
  payment_type  INT(2)                       DEFAULT NULL
  COMMENT '',
  post_fee      VARCHAR(50)
                COLLATE utf8_bin             DEFAULT NULL
  COMMENT '',
  status        INT(10)                      DEFAULT NULL
  COMMENT '状态：1、未付款，2、已付款，3、未发货，4、已发货，5、交易成功，6、交易关闭',
  create_time   DATETIME                     DEFAULT NULL
  COMMENT '订单创建时间',
  update_time   DATETIME                     DEFAULT NULL
  COMMENT '订单更新时间',
  payment_time  DATETIME                     DEFAULT NULL
  COMMENT '付款时间',
  consign_time  DATETIME                     DEFAULT NULL
  COMMENT '发货时间',
  end_time      DATETIME                     DEFAULT NULL
  COMMENT '交易完成时间',
  close_time    DATETIME                     DEFAULT NULL
  COMMENT '交易关闭时间',
  shipping_name VARCHAR(20)
                COLLATE utf8_bin             DEFAULT NULL
  COMMENT '物流名称',
  shipping_code VARCHAR(20)
                COLLATE utf8_bin             DEFAULT NULL
  COMMENT '物流单号',
  user_id       BIGINT(20)                   DEFAULT NULL
  COMMENT '用户id',
  buyer_message VARCHAR(100)
                COLLATE utf8_bin             DEFAULT NULL
  COMMENT '买家留言',
  buyer_nick    VARCHAR(50)
                COLLATE utf8_bin             DEFAULT NULL
  COMMENT '买家昵称',
  buyer_rate    INT(2)                       DEFAULT NULL
  COMMENT '买家是否已经评价',
  KEY create_time (create_time),
  KEY buyer_nick (buyer_nick),
  KEY status (status),
  KEY payment_type (payment_type)
)
  COMMENT '订单表';

SELECT *
FROM db_convenientbuy.cb_content;
