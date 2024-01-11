/* 

Cleaning the data


*/

SELECT *
FROM nashvillehousing.`nashville housing data for data cleaning`;




-- Standardize Date Format

SELECT SaleDate
FROM nashvillehousing.`nashville housing data for data cleaning`;

UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET SaleDate=DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %e, %Y'), '%d - %m - %Y');

-- ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
-- DROP COLUMN SaleDateConverted;




-- Populate Property Address if it is showing Null

SELECT *
FROM nashvillehousing.`nashville housing data for data cleaning`
-- WHERE PropertyAddress IS NULL
ORDER BY ParcelID;


SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, COALESCE(A.PropertyAddress, B.PropertyAddress) AS Address
FROM nashvillehousing.`nashville housing data for data cleaning` AS A
JOIN nashvillehousing.`nashville housing data for data cleaning` AS B
ON A.ParcelID = B.ParcelID AND A.UniqueID <> B.UniqueID
WHERE A.PropertyAddress IS NULL;




-- Breaking out Address into Individual Column(Address,City)

SELECT PropertyAddress
FROM nashvillehousing.`nashville housing data for data cleaning`;

USE nashvillehousing;

SELECT 
SUBSTRING(PropertyAddress, 1,LOCATE(',',PropertyAddress)-1) AS ADDRESS,
SUBSTRING(PropertyAddress,LOCATE(',',PropertyAddress)+1,LENGTH(PropertyAddress)) AS City
FROM nashvillehousing.`nashville housing data for data cleaning`;

ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
ADD PropertySplitAddress nvarchar(255);

UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,LOCATE(',',PropertyAddress)-1);

ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
ADD PropertySplitCity nvarchar(255);

UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET PropertySplitCity = SUBSTRING(PropertyAddress,LOCATE(',',PropertyAddress)+1,LENGTH(PropertyAddress));




-- Breaking out Owner Address into Individual Column(Address,City,State)

SELECT OwnerAddress
FROM nashvillehousing.`nashville housing data for data cleaning`;

SELECT 
SUBSTRING_INDEX(OwnerAddress, ',', 1) AS ADDRESS,
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1) AS City,
TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1)) AS State
FROM nashvillehousing.`nashville housing data for data cleaning`;

ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
ADD OwnerSplitAddress nvarchar(255);

UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);

ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
ADD OwnerSplitCity nvarchar(255);

UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1);

ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
ADD OwnerSplitState nvarchar(255);

UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET OwnerSplitState= TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));




-- Change Y AND N to Yes and No in 'Sold As Vacant'

SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
FROM nashvillehousing.`nashville housing data for data cleaning`
GROUP BY SoldAsVacant;

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant='Y' THEN 'Yes'
     WHEN SoldAsVacant='N' THEN 'No'
	 ELSE SoldAsVacant
END
FROM nashvillehousing.`nashville housing data for data cleaning`;


UPDATE nashvillehousing.`nashville housing data for data cleaning`
SET SoldAsVacant=CASE WHEN SoldAsVacant='Y' THEN 'Yes'
					  WHEN SoldAsVacant='N' THEN 'No'
					  ELSE SoldAsVacant
				 END;
                 
                 
                 
                 
-- Remove Duplicates

DELETE t
FROM nashvillehousing.`nashville housing data for data cleaning` t
JOIN (
    SELECT *,
           ROW_NUMBER() OVER (
           PARTITION BY ParcelID, 
						PropertyAddress, 
						SalePrice, 
                        SaleDate, 
                        LegalReference 
                        ORDER BY UniqueID
                        ) AS row_num
    FROM nashvillehousing.`nashville housing data for data cleaning`
) RowNUMCTE ON t.UniqueID = RowNUMCTE.UniqueID
WHERE row_num > 1;

-- Delete Unused Columns

ALTER TABLE nashvillehousing.`nashville housing data for data cleaning`
DROP COLUMN OwnerAddress, 
DROP COLUMN PropertyAddress, 
DROP COLUMN TaxDistrict;

SELECT *
FROM nashvillehousing.`nashville housing data for data cleaning`;

