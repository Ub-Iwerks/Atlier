## VPCの設定
resource "aws_vpc" "atlier-web_vpc_tf" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "atlier-web_vpc_tf"
  }
}

##サブネットの作成(1a)
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.atlier-web_vpc_tf.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "atlier-web_1a_tf"
  }
}

##サブネットの追加(1c)
resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.atlier-web_vpc_tf.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "atlier-web_1c_tf"
  }
}

##ルートテーブルの追加(0.0.0.0/0)
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.atlier-web_vpc_tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.atlier-web_GW_tf.id
  }
}

##ルートテーブルの追加(1a)
resource "aws_route_table_association" "puclic-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public-route.id
}

##ルートテーブルの追加(1c)
resource "aws_route_table_association" "puclic-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.public-route.id
}

##ゲートウェイの設定
resource "aws_internet_gateway" "atlier-web_GW_tf" {
  vpc_id = aws_vpc.atlier-web_vpc_tf.id

  tags = {
    Name = "atlier-web_GW_tf"
  }
}
