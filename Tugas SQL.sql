-- Tampilkan Employees yang memiliki FirstName berinisial huruf 'A'
SELECT *
FROM Employees
WHERE FirstName like 'A%'



-- Tampilkan jumlah Employees yang memiliki panjang LastName lebih dari 5 huruf
SELECT COUNT(*) 
FROM Employees
WHERE LENGTH("Lastname") > 5



-- Tampilkan customerName yang berasal dari negara Mexico
SELECT CustomerName 
FROM Customers
WHERE Country LIKE "Mexico"



-- Tampilkan total price untuk product yang memiliki kategori Seafood
SELECT SUM(Price)
FROM Products
WHERE CategoryID = "8"



-- Tampilkan average price untuk supplier yang berasal dari negara Jepang
SELECT AVG(Price)
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Country = "Japan"



-- Tampilkan kuantitas barang yang di order dengan nama produk = Geitost
SELECT Quantity
FROM OrderDetails
JOIN Products
ON OrderDetails.ProductID = Products.ProductID
WHERE ProductName = "Geitost"



-- Tampilkan jumlah produk berdasarkan kategori
SELECT Categories.CategoryName, COUNT(*) AS "JumlahProduk" 
FROM [Products]
JOIN [Categories]
ON Products.CategoryID = Categories.CategoryID
GROUP BY ("CategoryName")



-- Tampilkan seluruh customer yang memesan maupun tidak memesan dan tampilkan juga tanggal pemesanan
SELECT Customers.CustomerName, Orders.OrderDate FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID



-- Tampilkan jumlah pemesanan berdasarkan shipperName
SELECT Shippers.ShipperName, COUNT (*)
FROM Orders
JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID 
GROUP BY "ShipperName"



-- Tampilkan nama supplier yang total harga produknya dibawah 100
SELECT Suppliers.SupplierName, SUM(Products.Price) AS "Price < 100"
FROM Suppliers
JOIN Products
ON Suppliers.SupplierID = Products.SupplierID
GROUP BY Suppliers.SupplierName
HAVING SUM("Price") < 100



-- Tampilkan nama produk dan nama category yang termasuk kategori Beverages, Dairy Products, dan Condiments
SELECT Products.ProductName, Categories.CategoryName
FROM Products
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName IN ("Beverages","Dairy Products","Condiments")



-- Tampilkan nama customer, nama shipper, dan nomor telpon shipper untuk pemesanan pada tanggal 1996-07-08
SELECT Customers.CustomerName, Shippers.ShipperName, Shippers.Phone
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID
WHERE OrderDate="1996-07-08"



-- Tampilkan seluruh employee yang tidak memesan
SELECT e.FirstName AS "Employee Not Ordered Product", o.OrderID
FROM Employees e
LEFT JOIN Orders o
ON e.EmployeeID = o.EmployeeID
WHERE o.OrderID IS NULL



-- Tampilkan namaProduk, unit, harga, kuantitas, namaCustomer, namaShipper, negaraShipper untuk nama produk 'Queso Cabrales' dan tanggal pemesanan setelah tahun 1996
SELECT P.ProductName, P.Unit, P.Price, OD.Quantity, C.CustomerName, S.ShipperName, C.Country
FROM Products P
JOIN OrderDetails OD
ON P.ProductID = OD.ProductID
JOIN Orders O
ON OD.OrderID = O.OrderID
JOIN Customers C
ON O.CustomerID = C.CustomerID
JOIN Shippers S
ON O.ShipperID = S.ShipperID

WHERE O.OrderDate > "1996-12-31" AND P.ProductName = "Queso Cabrales"



-- Tampilkan setiap employee dan maksimum kuantitas yang employee melakukan pemesanan terbanyak
SELECT e.FirstName, MAX(OD.Quantity)
FROM Orders O
JOIN Employees E
ON O.EmployeeID = E.EmployeeID
JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
GROUP BY E.EmployeeID