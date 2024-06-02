--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

-- Started on 2024-06-03 05:35:29

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
-- TOC entry 209 (class 1259 OID 16885)
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    addressid character varying(50) NOT NULL,
    province character varying(30),
    city character varying(30),
    subdistrict character varying(50),
    address character varying(100),
    postalcode character varying(10),
    createdat date,
    updatedat date
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16917)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    brandid character varying(50) NOT NULL,
    brandname character varying(50),
    addressid character varying(50),
    logo character varying(255),
    createdat date,
    updatedat date
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17043)
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    cartid character varying(50) NOT NULL,
    productid character varying(50),
    customerid character varying(50),
    count integer,
    createdat date,
    updatedat date
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16966)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    categoryid character varying(50) NOT NULL,
    categoryname character varying(50),
    description text,
    createdat date,
    updatedat date
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 17017)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customerid character varying(50) NOT NULL,
    picture character varying(100),
    fullname character varying(100),
    addressid character varying(50),
    phone character varying(20),
    email character varying(100),
    password character varying(50),
    createdat date,
    updatedat date
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17116)
-- Name: orderdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderdetails (
    orderdetailid character varying(50) NOT NULL,
    orderid character varying(50),
    productid character varying(50),
    price integer,
    quantity integer,
    createdat date,
    updatedat date
);


ALTER TABLE public.orderdetails OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17091)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    orderid character varying(50) NOT NULL,
    customerid character varying(50),
    paymentid character varying(50),
    orderstatusid character varying(50),
    shipperid character varying(50),
    orderdate date,
    shipdate date,
    shiplimitdate date,
    freight double precision,
    paymendate date,
    createdat date,
    updatedat date
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17086)
-- Name: orderstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderstatus (
    orderstatusid character varying(50) NOT NULL,
    statusname character varying(50),
    createdat date,
    updatedat date
);


ALTER TABLE public.orderstatus OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17058)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    paymentid character varying(50) NOT NULL,
    paymenttype character varying(50),
    idallow boolean
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17000)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    productid character varying(50) NOT NULL,
    brandid character varying(50),
    productname character varying(50),
    productdescription text,
    categoryid character varying(50),
    unitprice double precision,
    unitsize character varying(5),
    unitinstock integer,
    isavalable boolean,
    pictures character varying[],
    createdat date,
    updatedat date
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17066)
-- Name: shippers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shippers (
    shipperid character varying(50) NOT NULL,
    companyname character varying(50),
    phone character varying(20)
);


ALTER TABLE public.shippers OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 17028)
-- Name: wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wishlist (
    wishlistid character varying(50) NOT NULL,
    productid character varying(50),
    customerid character varying(50),
    createdat date,
    updatedat date
);


ALTER TABLE public.wishlist OWNER TO postgres;

--
-- TOC entry 3384 (class 0 OID 16885)
-- Dependencies: 209
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (addressid, province, city, subdistrict, address, postalcode, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3385 (class 0 OID 16917)
-- Dependencies: 210
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (brandid, brandname, addressid, logo, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3390 (class 0 OID 17043)
-- Dependencies: 215
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (cartid, productid, customerid, count, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3386 (class 0 OID 16966)
-- Dependencies: 211
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (categoryid, categoryname, description, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3388 (class 0 OID 17017)
-- Dependencies: 213
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customerid, picture, fullname, addressid, phone, email, password, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3395 (class 0 OID 17116)
-- Dependencies: 220
-- Data for Name: orderdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderdetails (orderdetailid, orderid, productid, price, quantity, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3394 (class 0 OID 17091)
-- Dependencies: 219
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (orderid, customerid, paymentid, orderstatusid, shipperid, orderdate, shipdate, shiplimitdate, freight, paymendate, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3393 (class 0 OID 17086)
-- Dependencies: 218
-- Data for Name: orderstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderstatus (orderstatusid, statusname, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3391 (class 0 OID 17058)
-- Dependencies: 216
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (paymentid, paymenttype, idallow) FROM stdin;
\.


--
-- TOC entry 3387 (class 0 OID 17000)
-- Dependencies: 212
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (productid, brandid, productname, productdescription, categoryid, unitprice, unitsize, unitinstock, isavalable, pictures, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3392 (class 0 OID 17066)
-- Dependencies: 217
-- Data for Name: shippers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shippers (shipperid, companyname, phone) FROM stdin;
\.


--
-- TOC entry 3389 (class 0 OID 17028)
-- Dependencies: 214
-- Data for Name: wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wishlist (wishlistid, productid, customerid, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 3208 (class 2606 OID 16889)
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (addressid);


--
-- TOC entry 3210 (class 2606 OID 16921)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (brandid);


--
-- TOC entry 3220 (class 2606 OID 17047)
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (cartid);


--
-- TOC entry 3212 (class 2606 OID 16972)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (categoryid);


--
-- TOC entry 3216 (class 2606 OID 17021)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customerid);


--
-- TOC entry 3230 (class 2606 OID 17120)
-- Name: orderdetails orderdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_pkey PRIMARY KEY (orderdetailid);


--
-- TOC entry 3228 (class 2606 OID 17095)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);


--
-- TOC entry 3226 (class 2606 OID 17090)
-- Name: orderstatus orderstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatus
    ADD CONSTRAINT orderstatus_pkey PRIMARY KEY (orderstatusid);


--
-- TOC entry 3222 (class 2606 OID 17062)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (paymentid);


--
-- TOC entry 3214 (class 2606 OID 17006)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- TOC entry 3224 (class 2606 OID 17070)
-- Name: shippers shippers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shippers
    ADD CONSTRAINT shippers_pkey PRIMARY KEY (shipperid);


--
-- TOC entry 3218 (class 2606 OID 17032)
-- Name: wishlist wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY (wishlistid);


--
-- TOC entry 3231 (class 2606 OID 16922)
-- Name: brands brands_addressid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_addressid_fkey FOREIGN KEY (addressid) REFERENCES public.addresses(addressid) ON UPDATE CASCADE;


--
-- TOC entry 3238 (class 2606 OID 17053)
-- Name: cart cart_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid) ON UPDATE CASCADE;


--
-- TOC entry 3237 (class 2606 OID 17048)
-- Name: cart cart_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON UPDATE CASCADE;


--
-- TOC entry 3234 (class 2606 OID 17022)
-- Name: customers customers_addressid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_addressid_fkey FOREIGN KEY (addressid) REFERENCES public.addresses(addressid);


--
-- TOC entry 3243 (class 2606 OID 17121)
-- Name: orderdetails orderdetails_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON UPDATE CASCADE;


--
-- TOC entry 3244 (class 2606 OID 17126)
-- Name: orderdetails orderdetails_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON UPDATE CASCADE;


--
-- TOC entry 3239 (class 2606 OID 17096)
-- Name: orders orders_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid) ON UPDATE CASCADE;


--
-- TOC entry 3241 (class 2606 OID 17106)
-- Name: orders orders_orderstatusid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_orderstatusid_fkey FOREIGN KEY (orderstatusid) REFERENCES public.orderstatus(orderstatusid) ON UPDATE CASCADE;


--
-- TOC entry 3240 (class 2606 OID 17101)
-- Name: orders orders_paymentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_paymentid_fkey FOREIGN KEY (paymentid) REFERENCES public.payments(paymentid) ON UPDATE CASCADE;


--
-- TOC entry 3242 (class 2606 OID 17111)
-- Name: orders orders_shipperid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_shipperid_fkey FOREIGN KEY (shipperid) REFERENCES public.shippers(shipperid) ON UPDATE CASCADE;


--
-- TOC entry 3232 (class 2606 OID 17007)
-- Name: products products_brandid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_brandid_fkey FOREIGN KEY (brandid) REFERENCES public.brands(brandid) ON UPDATE CASCADE;


--
-- TOC entry 3233 (class 2606 OID 17012)
-- Name: products products_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.category(categoryid) ON UPDATE CASCADE;


--
-- TOC entry 3236 (class 2606 OID 17038)
-- Name: wishlist wishlist_customerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_customerid_fkey FOREIGN KEY (customerid) REFERENCES public.customers(customerid) ON UPDATE CASCADE;


--
-- TOC entry 3235 (class 2606 OID 17033)
-- Name: wishlist wishlist_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlist
    ADD CONSTRAINT wishlist_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON UPDATE CASCADE;


-- Completed on 2024-06-03 05:35:29

--
-- PostgreSQL database dump complete
--

