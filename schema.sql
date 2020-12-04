CREATE DATABASE skincare_app;

CREATE TABLE users (id SERIAL PRIMARY KEY, first_name TEXT, last_name TEXT, email_address TEXT, password_digest TEXT);

To add new data, just key in insert into
INSERT INTO users(first_name, last_name, email, password_digest) VALUES('#{first_name}', '#{last_name}', '#{user_email}', '#{password_digest}')

ALTER TABLE users RENAME COLUMN email_address TO email;





CREATE TABLE skinlog (id SERIAL PRIMARY KEY, skin_concern TEXT, day_no TEXT, date_time TEXT, image_url TEXT, products TEXT, details TEXT);


INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('Dry and dehydrated', 'No. 1', '3 December, 3pm', 'https://d1dxbybsjrhthz.cloudfront.net/wp-content/uploads/2019/12/How-to-treat-oily-dehydrated-skin.jpg', 'Nivea moisturiser', 'After using this product, my skin looked even more dull with drier texture');

INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('Inflammation', 'No. 2', '4 December, 6pm', 'https://cdn.shopify.com/s/files/1/2006/9059/articles/close-view-of-womans-face-1138531_2800x.png?v=1579067749', 'Clean and Clear cleanser', 'This product contains ingredients which was very harsh for my skin! I regretted using this');

INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('Inflammation', 'No. 2', '4 December, 6pm', 'https://cdn.shopify.com/s/files/1/2006/9059/articles/close-view-of-womans-face-1138531_2800x.png?v=1579067749', 'Clean and Clear cleanser', 'This product contains ingredients which was very harsh for my skin! I regretted using this');

INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('Pigmentation', 'No. 3', '9 December, 6pm', 'https://3sefjs3boqbsy32hd4hca628-wpengine.netdna-ssl.com/wp-content/uploads/2019/02/Melasma.jpg', 'No products used at the moment', 'I have big pores and dull skin with pigmentation, please help!');

INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('Skin is slightly better', 'No. 9', '20 December, 6pm', 'https://cdn.shopify.com/s/files/1/0047/9507/2581/articles/Untitled_design_-_2019-03-20T154735.922_1024x1024.jpg?v=1553096866', 'Only been using one product', 'Loving the results that I have with using Kiehls spot corrector!');

INSERT INTO skinlog (skin_concern, day_no, date_time, image_url, products, details) VALUES('Pigmentation', 'No. 26', '30 December, 6pm', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSSAz4Db_i4pkGaJi4-PSEij_Mma875jftiw&usqp=CAU', 'Kiehls spot corrector', 'My skin is restored!');




