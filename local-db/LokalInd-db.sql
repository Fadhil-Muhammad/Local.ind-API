--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2024-06-12 12:49:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 17433)
-- Name: Brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Brands" (
    "BrandId" character varying(50) NOT NULL,
    "BrandName" character varying(50) NOT NULL,
    "Address" character varying(100),
    "Logo" text NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL
);


ALTER TABLE public."Brands" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17484)
-- Name: Cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cart" (
    "CartId" character varying(50) NOT NULL,
    "ProductId" character varying(50) NOT NULL,
    "CustomerId" character varying(50) NOT NULL,
    "Count" integer NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL,
    "IsActive" boolean DEFAULT true
);


ALTER TABLE public."Cart" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17438)
-- Name: Categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Categories" (
    "CategoryId" character varying(50) NOT NULL,
    "CategoryName" character varying(50) NOT NULL,
    "Description" text NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL
);


ALTER TABLE public."Categories" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17462)
-- Name: Customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customers" (
    "CustomerId" character varying(50) NOT NULL,
    "Picture" text NOT NULL,
    "FullName" character varying(100) NOT NULL,
    "Address" character varying(100),
    "Phone" character varying(20) NOT NULL,
    "Email" character varying(100) NOT NULL,
    "Password" character varying(300) NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL,
    "isBrand" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Customers" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17504)
-- Name: OrderStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderStatus" (
    "OrderStatusId" character varying(50) NOT NULL,
    "StatusName" character varying(50) NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL
);


ALTER TABLE public."OrderStatus" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17595)
-- Name: Orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orders" (
    "OrderId" character varying(50) NOT NULL,
    "CustomerId" character varying(50) NOT NULL,
    "PaymentId" character varying(50) NOT NULL,
    "OrderStatusId" character varying(50) NOT NULL,
    "ShipperId" character varying(50) NOT NULL,
    "OrderDate" date NOT NULL,
    "ShipDate" date NOT NULL,
    "ShipLimitDate" date NOT NULL,
    "Freight" double precision NOT NULL,
    "PaymentDate" date NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL,
    "ProductId" character varying(50),
    "Price" integer NOT NULL,
    "Quantity" integer NOT NULL,
    "CartId" character varying(50) NOT NULL
);


ALTER TABLE public."Orders" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17499)
-- Name: Payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payments" (
    "PaymentId" character varying(50) NOT NULL,
    "PaymentType" character varying(50) NOT NULL,
    "idAllow" boolean NOT NULL
);


ALTER TABLE public."Payments" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 17445)
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    "ProductId" character varying(50) NOT NULL,
    "BrandId" character varying(50) NOT NULL,
    "ProductName" character varying(50) NOT NULL,
    "ProductDescription" text NOT NULL,
    "CategoryId" character varying(50) NOT NULL,
    "UnitPrice" double precision NOT NULL,
    "UnitSize" character varying(5) NOT NULL,
    "UnitInStock" integer NOT NULL,
    "isAvailable" boolean NOT NULL,
    "Pictures" character varying[] NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17509)
-- Name: Shippers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Shippers" (
    "ShipperId" character varying(50) NOT NULL,
    "CompanyName" character varying(50) NOT NULL,
    "Phone" character varying(20) NOT NULL
);


ALTER TABLE public."Shippers" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17469)
-- Name: Wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Wishlist" (
    "WishlistId" character varying(50) NOT NULL,
    "ProductId" character varying(50) NOT NULL,
    "CustomerId" character varying(50) NOT NULL,
    "CreatedAt" date NOT NULL,
    "UpdatedAt" date NOT NULL
);


ALTER TABLE public."Wishlist" OWNER TO postgres;

--
-- TOC entry 3372 (class 0 OID 17433)
-- Dependencies: 209
-- Data for Name: Brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Brands" ("BrandId", "BrandName", "Address", "Logo", "CreatedAt", "UpdatedAt") FROM stdin;
c712f334-13d1-47ea-9017-762373693eaa	Erigo	Jl Kantor Erigo 22 Jakarta	dawdawdwad.png	2024-06-04	2024-06-04
9d347869-5aa9-426d-8d60-c06a5223b1d3	Eiger	Jl Eiger no 1A 211	brand-logo/Eiger/1718108584905_eiger.png	2024-06-11	2024-06-11
\.


--
-- TOC entry 3377 (class 0 OID 17484)
-- Dependencies: 214
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cart" ("CartId", "ProductId", "CustomerId", "Count", "CreatedAt", "UpdatedAt", "IsActive") FROM stdin;
4e3889fe-301e-4a1c-8dd0-8e69af67a111	e3358352-2c93-463d-9000-02f4bb8d6236	ae40a342-0795-4219-94b8-926e3ec727db	22	2024-06-06	2024-06-06	t
19b8d5e8-94f6-404f-88f6-9485e46274db	e3358352-2c93-463d-9000-02f4bb8d6236	0df986a0-923e-45f1-946b-de19943431d8	3231	2024-06-06	2024-06-06	t
13d674d2-5891-44eb-9908-d0a7f309c58f	e3358352-2c93-463d-9000-02f4bb8d6236	0df986a0-923e-45f1-946b-de19943431d8	10	2024-06-06	2024-06-06	f
6ac0f804-d12c-4776-9fd7-ee64ae6b9474	e3358352-2c93-463d-9000-02f4bb8d6236	0df986a0-923e-45f1-946b-de19943431d8	1	2024-06-06	2024-06-06	f
1d3d89f3-800d-4021-bf2f-2447c6a524f7	05c07707-1d1d-4ab9-b40c-9bd5c94b58f6	0df986a0-923e-45f1-946b-de19943431d8	3	2024-06-06	2024-06-06	f
e0bd7c16-6652-4234-963d-eb926be91756	e3358352-2c93-463d-9000-02f4bb8d6236	17cbc274-d44f-4a6d-83d5-63a9e2744a9a	22	2024-06-11	2024-06-11	t
\.


--
-- TOC entry 3373 (class 0 OID 17438)
-- Dependencies: 210
-- Data for Name: Categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Categories" ("CategoryId", "CategoryName", "Description", "CreatedAt", "UpdatedAt") FROM stdin;
2f4b726b-1a13-4203-95ab-0d012fa8af0f	Polo Shirt	Elegant, semi-formal	2024-06-04	2024-06-04
a2796ddb-8db8-434e-9b81-b2ac5a70fc34	T-Shirt	Comfortable, trendy	2024-06-04	2024-06-04
\.


--
-- TOC entry 3375 (class 0 OID 17462)
-- Dependencies: 212
-- Data for Name: Customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Customers" ("CustomerId", "Picture", "FullName", "Address", "Phone", "Email", "Password", "CreatedAt", "UpdatedAt", "isBrand") FROM stdin;
0df986a0-923e-45f1-946b-de19943431d8	1.png	Fadhil Muhammad	Jl Juragan Sinda Raya	08323132123	fadhil@gmail.com	$2a$10$HR3ZFMOiRM9Yuynbt7kup.H5mC.kUXPpRgtp49qD.Qlpssix/JYC.	2024-06-05	2024-06-05	f
ae40a342-0795-4219-94b8-926e3ec727db	1.png2	Fadhil Muhammad2	Jl Juragan Sinda Raya2	083231321232	fadhil@gmail.com2	$2a$10$TqoBggoBy9BIW.KeFfsVI.h403nYnlwgRfbeXd7Ym8a5ZLtt7AtkW	2024-06-06	2024-06-06	f
cde20d82-fbb1-4273-9c03-76a8960935b0	erigo.png2	Erigo	JL Erigo	ErigoPhone	Erigo@gmail.com	$2a$10$kmLAP7yCcDbJBtRaasv9q.WchTTZfYvY92gFQfs4mOHR/RsXDd3KO	2024-06-06	2024-06-06	t
90b267ed-9320-450a-a2fc-eee36cafab20	erigo.png23	Erigo3	JL Erigo3	083213314	Erigo@gmail.com3	$2a$10$vV1dVHsje3Z9kN5y9ZiRaO8KQIzmZDQ/8h9LpHkZNc5KbeNysUO0a	2024-06-07	2024-06-07	t
f1b1bc95-eb34-4020-9d6d-38793b64093b	https://storage.googleapis.com/lokalind-img-bucket/user-picture/user.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=cloud-storage-access%40lokal-ind.iam.gserviceaccount.com%2F20240610%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240610T112705Z&X-Goog-Expires=900&X-Goog-SignedHeaders=host&X-Goog-Signature=7419d1eb4b3ef3aa7254f0cad76cad0e00ca02e0c73fdd06d989f38ce7742543340c368973a009eec13e12ffc6dde74d4dd4b993d18a837636ff8a60f3bd8d3bc0ce72ff98e7322e6f728b29bf6533c7b61f9073494d59f07a38a4baaea21fdbee22245217b8ae52a8a56e6b3756d260797ff5a2d497fc6a12ba7682cf38d9d367828fddbdd2c5a84f63760e24f1fb6d37d0cdb985774f729f410b09b737ddd8c1d067dc78b20474dec6f517b0f632cfd2d1ede8d6c1dbdd99e4b6a04ca442af83a146518afa1e4d701ba29245f50f27c8efbf2f20d422f18f842361ef36e5e781c88b17c1ec60e432b6f05e66e796ae3b26798529e725bb5e488c1896506423	nopic	nopic.jpg	083213123	nopic@gmail.com	$2a$10$6L/xtEKMRWTcrRu2yrG4KuUTs1tfQXpAcilXiecNEmlNClUUPEOMC	2024-06-10	2024-06-10	f
17cbc274-d44f-4a6d-83d5-63a9e2744a9a	https://storage.googleapis.com/lokalind-img-bucket/user-picture/user.jpg?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=cloud-storage-access%40lokal-ind.iam.gserviceaccount.com%2F20240611%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240611T014525Z&X-Goog-Expires=900&X-Goog-SignedHeaders=host&X-Goog-Signature=7743d22f2c4813dbbfec6544d712bec7700308a46a244db2207c4173c10b217ba9afd1ec594e81a089a8b371f87513c8e579a1c6d8f007be2a5c8697ac74445ff7458ef3efeceb1e8ea2c0df65b6ed9b000a7833d0198200e598cc248417422aacf6f5ac7c10e02957f4fe2104369bccdc345b5f1d1af8119207b7de3a0d6ef0de4e97dde50cd56b92286b32196880fdd13b497db1612fc784229e01cda810b8d424d791ea0454156bff8125ea0878afbd0035b049ff69712dbd0013157a120664ed47b24d2734ff5311407fd967d83d332ebcadc8536e5e53d555761d29291cf677f6f0498a84108ad5f76590972ec8457c6821f6a433204a1a9cc48f3d1aa0	withpic	withpic.jpg	083213123	withpic@gmail.com	$2a$10$Vgogju7nFSLEe7ai0Y1VzeVJW.8GR7mZ6k5F4HjHdeSB/aLfIGORy	2024-06-11	2024-06-11	f
\.


--
-- TOC entry 3379 (class 0 OID 17504)
-- Dependencies: 216
-- Data for Name: OrderStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrderStatus" ("OrderStatusId", "StatusName", "CreatedAt", "UpdatedAt") FROM stdin;
bd9fe794-365c-4f1a-b74c-c3d1e2643b13	Finished	2024-06-04	2024-06-04
f8681598-6cda-4394-93e9-ab71293974a7	Waiting Courir	2024-06-04	2024-06-04
9b38b412-20ed-4ca1-b361-e6a410757e58	On The Way	2024-06-05	2024-06-05
962f440d-81ca-4cad-8e74-1981fa9299b5	Processing	2024-06-06	2024-06-06
\.


--
-- TOC entry 3381 (class 0 OID 17595)
-- Dependencies: 218
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Orders" ("OrderId", "CustomerId", "PaymentId", "OrderStatusId", "ShipperId", "OrderDate", "ShipDate", "ShipLimitDate", "Freight", "PaymentDate", "CreatedAt", "UpdatedAt", "ProductId", "Price", "Quantity", "CartId") FROM stdin;
02b2c13e-7819-4cd7-8d87-e4178e148291	0df986a0-923e-45f1-946b-de19943431d8	fb4bbc8f-1df0-4e51-b72d-47176f12e4dc	962f440d-81ca-4cad-8e74-1981fa9299b5	6085fa2c-57e8-466a-b45f-bfaef1828061	2024-06-06	2024-06-07	2024-06-09	1.1	2024-06-06	2024-06-06	2024-06-06	05c07707-1d1d-4ab9-b40c-9bd5c94b58f6	120000	3	1d3d89f3-800d-4021-bf2f-2447c6a524f7
b64b39da-e60c-4cb6-96e4-5b5282f851be	0df986a0-923e-45f1-946b-de19943431d8	f70c21ca-27ca-4a48-8983-0dc96e567259	962f440d-81ca-4cad-8e74-1981fa9299b5	6085fa2c-57e8-466a-b45f-bfaef1828061	2024-06-06	2024-06-07	2024-06-09	4	2024-06-06	2024-06-06	2024-06-06	e3358352-2c93-463d-9000-02f4bb8d6236	160000	10	13d674d2-5891-44eb-9908-d0a7f309c58f
4cb527d7-e26d-4c76-973c-82cdffb5529f	0df986a0-923e-45f1-946b-de19943431d8	f70c21ca-27ca-4a48-8983-0dc96e567259	962f440d-81ca-4cad-8e74-1981fa9299b5	6085fa2c-57e8-466a-b45f-bfaef1828061	2024-06-06	2024-06-07	2024-06-09	23	2024-06-06	2024-06-06	2024-06-06	e3358352-2c93-463d-9000-02f4bb8d6236	160000	1	6ac0f804-d12c-4776-9fd7-ee64ae6b9474
cb9db094-5fef-477a-a7cd-ec5a75ac77f4	0df986a0-923e-45f1-946b-de19943431d8	f70c21ca-27ca-4a48-8983-0dc96e567259	bd9fe794-365c-4f1a-b74c-c3d1e2643b13	6085fa2c-57e8-466a-b45f-bfaef1828061	2024-06-06	2024-06-07	2024-06-09	23	2024-06-06	2024-06-06	2024-06-06	05c07707-1d1d-4ab9-b40c-9bd5c94b58f6	120000	3	1d3d89f3-800d-4021-bf2f-2447c6a524f7
\.


--
-- TOC entry 3378 (class 0 OID 17499)
-- Dependencies: 215
-- Data for Name: Payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payments" ("PaymentId", "PaymentType", "idAllow") FROM stdin;
f70c21ca-27ca-4a48-8983-0dc96e567259	COD	t
fb4bbc8f-1df0-4e51-b72d-47176f12e4dc	Transfer	t
\.


--
-- TOC entry 3374 (class 0 OID 17445)
-- Dependencies: 211
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Products" ("ProductId", "BrandId", "ProductName", "ProductDescription", "CategoryId", "UnitPrice", "UnitSize", "UnitInStock", "isAvailable", "Pictures", "CreatedAt", "UpdatedAt") FROM stdin;
e3358352-2c93-463d-9000-02f4bb8d6236	c712f334-13d1-47ea-9017-762373693eaa	Erigo Blue Polo-Shirt	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dictum ultricies eros, et dapibus risus ullamcorper a. Suspendisse eget augue vitae dolor aliquam congue at non odio. Morbi eget ultricies turpis. Fusce mattis velit ut nunc convallis, vel euismod metus porta. Morbi faucibus quam eget mauris molestie, in sagittis quam elementum. Nam tincidunt id mauris sed maximus. Fusce id rutrum nibh. Cras pretium augue quis lobortis rutrum. Vestibulum nibh lectus, pulvinar non leo quis, blandit ullamcorper ipsum. Suspendisse blandit sapien auctor sollicitudin euismod. Aliquam ac ipsum elit. Vivamus nisl libero, tristique eget molestie eget, pellentesque at dolor. Cras sed tortor lacinia, fermentum nisl sed, egestas nisl. Pellentesque dui enim, semper eget porttitor ac, mollis id magna. Morbi finibus congue neque ut hendrerit. Donec non ipsum ut turpis tincidunt porttitor a nec sapien. Maecenas pellentesque turpis id augue egestas, ornare consequat urna finibus. Vestibulum non quam in justo euismod egestas quis vitae arcu. Nunc et eros nec elit cursus varius.	2f4b726b-1a13-4203-95ab-0d012fa8af0f	160000	S-XL	20	t	{x.png,y.png,z.png}	2024-06-04	2024-06-04
05c07707-1d1d-4ab9-b40c-9bd5c94b58f6	c712f334-13d1-47ea-9017-762373693eaa	Erigo Red T-Shirt	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dictum ultricies eros, et dapibus risus ullamcorper a. Suspendisse eget augue vitae dolor aliquam congue at non odio. Morbi eget ultricies turpis. Fusce mattis velit ut nunc convallis, vel euismod metus porta. Morbi faucibus quam eget mauris molestie, in sagittis quam elementum. Nam tincidunt id mauris sed maximus. Fusce id rutrum nibh. Cras pretium augue quis lobortis rutrum. Vestibulum nibh lectus, pulvinar non leo quis, blandit ullamcorper ipsum. Suspendisse blandit sapien auctor sollicitudin euismod. Aliquam ac ipsum elit. Vivamus nisl libero, tristique eget molestie eget, pellentesque at dolor. Cras sed tortor lacinia, fermentum nisl sed, egestas nisl. Pellentesque dui enim, semper eget porttitor ac, mollis id magna. Morbi finibus congue neque ut hendrerit. Donec non ipsum ut turpis tincidunt porttitor a nec sapien. Maecenas pellentesque turpis id augue egestas, ornare consequat urna finibus. Vestibulum non quam in justo euismod egestas quis vitae arcu. Nunc et eros nec elit cursus varius.	a2796ddb-8db8-434e-9b81-b2ac5a70fc34	120000	S-XL	40	t	{1.png,2.png,3.png}	2024-06-04	2024-06-04
\.


--
-- TOC entry 3380 (class 0 OID 17509)
-- Dependencies: 217
-- Data for Name: Shippers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Shippers" ("ShipperId", "CompanyName", "Phone") FROM stdin;
6085fa2c-57e8-466a-b45f-bfaef1828061	JNE	08123213231
24f31f9b-9ba6-423a-ace0-d7d7d709ecfb	SiCepat	08323132
\.


--
-- TOC entry 3376 (class 0 OID 17469)
-- Dependencies: 213
-- Data for Name: Wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Wishlist" ("WishlistId", "ProductId", "CustomerId", "CreatedAt", "UpdatedAt") FROM stdin;
63c2a111-2644-4952-88aa-096dd4d449ad	e3358352-2c93-463d-9000-02f4bb8d6236	0df986a0-923e-45f1-946b-de19943431d8	2024-06-06	2024-06-06
\.


--
-- TOC entry 3202 (class 2606 OID 17437)
-- Name: Brands Brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Brands"
    ADD CONSTRAINT "Brands_pkey" PRIMARY KEY ("BrandId");


--
-- TOC entry 3212 (class 2606 OID 17488)
-- Name: Cart Cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_pkey" PRIMARY KEY ("CartId");


--
-- TOC entry 3204 (class 2606 OID 17444)
-- Name: Categories Categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Categories"
    ADD CONSTRAINT "Categories_pkey" PRIMARY KEY ("CategoryId");


--
-- TOC entry 3208 (class 2606 OID 17468)
-- Name: Customers Customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customers"
    ADD CONSTRAINT "Customers_pkey" PRIMARY KEY ("CustomerId");


--
-- TOC entry 3216 (class 2606 OID 17508)
-- Name: OrderStatus OrderStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderStatus"
    ADD CONSTRAINT "OrderStatus_pkey" PRIMARY KEY ("OrderStatusId");


--
-- TOC entry 3220 (class 2606 OID 17599)
-- Name: Orders Orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_pkey" PRIMARY KEY ("OrderId");


--
-- TOC entry 3214 (class 2606 OID 17503)
-- Name: Payments Payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payments"
    ADD CONSTRAINT "Payments_pkey" PRIMARY KEY ("PaymentId");


--
-- TOC entry 3206 (class 2606 OID 17451)
-- Name: Products Products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY ("ProductId");


--
-- TOC entry 3218 (class 2606 OID 17513)
-- Name: Shippers Shippers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Shippers"
    ADD CONSTRAINT "Shippers_pkey" PRIMARY KEY ("ShipperId");


--
-- TOC entry 3210 (class 2606 OID 17473)
-- Name: Wishlist Wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_pkey" PRIMARY KEY ("WishlistId");


--
-- TOC entry 3226 (class 2606 OID 17494)
-- Name: Cart Cart_CustomerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_CustomerId_fkey" FOREIGN KEY ("CustomerId") REFERENCES public."Customers"("CustomerId") ON UPDATE CASCADE;


--
-- TOC entry 3225 (class 2606 OID 17489)
-- Name: Cart Cart_ProductId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_ProductId_fkey" FOREIGN KEY ("ProductId") REFERENCES public."Products"("ProductId") ON UPDATE CASCADE;


--
-- TOC entry 3232 (class 2606 OID 17625)
-- Name: Orders Orders_CartId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_CartId_fkey" FOREIGN KEY ("CartId") REFERENCES public."Cart"("CartId") ON UPDATE CASCADE;


--
-- TOC entry 3227 (class 2606 OID 17600)
-- Name: Orders Orders_CustomerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_CustomerId_fkey" FOREIGN KEY ("CustomerId") REFERENCES public."Customers"("CustomerId") ON UPDATE CASCADE;


--
-- TOC entry 3229 (class 2606 OID 17610)
-- Name: Orders Orders_OrderStatusId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_OrderStatusId_fkey" FOREIGN KEY ("OrderStatusId") REFERENCES public."OrderStatus"("OrderStatusId") ON UPDATE CASCADE;


--
-- TOC entry 3228 (class 2606 OID 17605)
-- Name: Orders Orders_PaymentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_PaymentId_fkey" FOREIGN KEY ("PaymentId") REFERENCES public."Payments"("PaymentId") ON UPDATE CASCADE;


--
-- TOC entry 3231 (class 2606 OID 17620)
-- Name: Orders Orders_ProductId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_ProductId_fkey" FOREIGN KEY ("ProductId") REFERENCES public."Products"("ProductId") ON UPDATE CASCADE;


--
-- TOC entry 3230 (class 2606 OID 17615)
-- Name: Orders Orders_ShipperId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_ShipperId_fkey" FOREIGN KEY ("ShipperId") REFERENCES public."Shippers"("ShipperId") ON UPDATE CASCADE;


--
-- TOC entry 3221 (class 2606 OID 17452)
-- Name: Products Products_BrandId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_BrandId_fkey" FOREIGN KEY ("BrandId") REFERENCES public."Brands"("BrandId") ON UPDATE CASCADE;


--
-- TOC entry 3222 (class 2606 OID 17457)
-- Name: Products Products_CategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_CategoryId_fkey" FOREIGN KEY ("CategoryId") REFERENCES public."Categories"("CategoryId") ON UPDATE CASCADE;


--
-- TOC entry 3224 (class 2606 OID 17479)
-- Name: Wishlist Wishlist_CustomerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_CustomerId_fkey" FOREIGN KEY ("CustomerId") REFERENCES public."Customers"("CustomerId") ON UPDATE CASCADE;


--
-- TOC entry 3223 (class 2606 OID 17474)
-- Name: Wishlist Wishlist_ProductId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_ProductId_fkey" FOREIGN KEY ("ProductId") REFERENCES public."Products"("ProductId") ON UPDATE CASCADE;


-- Completed on 2024-06-12 12:49:19

--
-- PostgreSQL database dump complete
--

