create table Addresses (
	AddressId varchar(50) primary key,
	Province varchar(30),
	City varchar(30),
	SubDistrict varchar(50),
	Address varchar(100),
	PostalCode varchar(10),
	CreatedAt date,
	UpdatedAt date
);

create table Brands (
	BrandId varchar(50) primary key,
	BrandName varchar(50),
	AddressId varchar(50),	
	foreign key (AddressId) references Addresses(AddressId) ON UPDATE CASCADE,
	Logo varchar(255),
	CreatedAt date,
	UpdatedAt date
);

create table Category (
	CategoryId varchar(50) primary key,
	CategoryName varchar(50),
	Description TEXT,
	Createdat date,
	UpdatedAt date
);

create table Products(
	ProductId varchar(50) Primary key,
	BrandId varchar(50),
	foreign key (BrandId) references Brands(BrandId) ON UPDATE CASCADE,
	ProductName varchar(50),
	ProductDescription TEXT,
	CategoryId varchar(50),
	foreign key (CategoryId) REFERENCES Category(CategoryId) ON UPDATE CASCADE,
	UnitPrice Double precision,
	UnitSize varchar(5),
	UnitInStock int,
	isAvalable Boolean,
	Pictures varchar[],
	Createdat date,
	UpdatedAt date
);

create table Customers(
	CustomerId varchar(50) primary key,
	Picture varchar(100),
	FullName varchar(100),
	AddressId varchar(50),
	foreign key (AddressId) REFERENCES Addresses(AddressId),
	Phone varchar(20),
	Email varchar(100),
	Password varchar(50),
	CreatedAt date,
	UpdatedAt date
);

create table Wishlist(
	WishlistId varchar(50) primary key,
	ProductId varchar(50),
	FOREIGN key	(ProductId) references Products(ProductId) on update cascade,
	CustomerId varchar(50),
	foreign key (CustomerId) references Customers(CustomerId) on update cascade,
	CreatedAt date,
	UpdatedAt date
);

create table Cart(
	CartId varchar(50) primary key,
	ProductId varchar(50),
	FOREIGN key	(ProductId) references Products(ProductId) on update cascade,
	CustomerId varchar(50),
	foreign key (CustomerId) references Customers(CustomerId) on update cascade,
	Count int,
	CreatedAt date,
	UpdatedAt date
);

create table Payments(
	PaymentId varchar(50) primary KEY,
	PaymentType varchar(50),
	idAllow boolean
);

create table OrderStatus(
	OrderStatusId varchar(50) primary key,
	StatusName varchar(50),
	CreatedAt Date,
	UpdatedAt Date
);

create table Shippers(
	ShipperId varchar(50) primary key,
	CompanyName varchar(50),
	Phone varchar(20)
);

create table Orders(
	OrderId varchar(50) Primary key,
	CustomerId varchar(50),
	foreign key (CustomerId) references Customers(CustomerId) on update cascade,
	PaymentId varchar(50),
	foreign key (PaymentId) references Payments(PaymentId) on update cascade,
	OrderStatusId varchar(50),
	foreign key (OrderStatusId) references OrderStatus(OrderStatusId) on update cascade,
	ShipperId varchar(50),
	foreign key (ShipperId) references Shippers(ShipperId) on update cascade,
	OrderDate date,
	ShipDate date,
	ShipLimitDate date,
	Freight Double precision,
	PaymenDate Date,
	CreatedAt Date,
	UpdatedAt Date
);


create table OrderDetails(
	OrderDetailId varchar(50) primary key,
	OrderId varchar(50),
	foreign key (OrderId) references Orders(OrderId) on update cascade,
	ProductId varchar(50),
	FOREIGN key	(ProductId) references Products(ProductId) on update cascade,	
	Price int,
	Quantity int,
	CreatedAt date,
	UpdatedAt date
);


