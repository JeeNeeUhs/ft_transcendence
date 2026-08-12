INSERT INTO categories (name) VALUES 
('Science'), 
('History'),
('Geography'),
('Sports'),
('Art'),
('Technology'),
('Literature'),
('Music'),
('Movies'),
('Gaming')
ON CONFLICT (name) DO NOTHING;

INSERT INTO questions (category_id, question_text, option_a, option_b, option_c, option_d, correct_option, difficulty)
VALUES
-- Science (Bilim)
(1, 'Suyun deniz seviyesindeki kaynama noktası kaç santigrat derecedir?', '0 °C', '50 °C', '100 °C', '150 °C', 'C', 'Easy'),
(1, 'Dünya''nın doğal uydusunun adı nedir?', 'Mars', 'Ay', 'Venüs', 'Merkür', 'B', 'Easy'),
(1, 'İnsan vücudunda kanı pompalayan organ hangisidir?', 'Akciğer', 'Karaciğer', 'Böbrek', 'Kalp', 'D', 'Easy'),
(1, 'Bitkilerin güneş ışığını kullanarak besin üretmesine ne ad verilir?', 'Fotosentez', 'Solunum', 'Fermantasyon', 'Sindirim', 'A', 'Easy'),
(1, 'Dünya''daki en yaygın gaz hangisidir?', 'Oksijen', 'Karbondioksit', 'Azot', 'Hidrojen', 'C', 'Easy'),
(1, 'Bir maddenin katı hâlden sıvı hâle geçmesine ne ad verilir?', 'Donma', 'Erime', 'Buharlaşma', 'Yoğuşma', 'B', 'Easy'),
(1, 'İnsanlarda solunum sırasında akciğerlere alınan temel gaz hangisidir?', 'Azot', 'Helyum', 'Oksijen', 'Hidrojen', 'C', 'Easy'),
(1, 'Elektrik akımının birimi aşağıdakilerden hangisidir?', 'Volt', 'Watt', 'Ohm', 'Amper', 'D', 'Easy'),
(1, 'Yer çekimi kuvvetinin etkisiyle bir cismin Dünya''ya doğru hareket etmesine ne denir?', 'Yansıma', 'Düşme', 'Kırılma', 'Genleşme', 'B', 'Easy'),
(1, 'Güneş Sistemi''nin merkezinde bulunan gök cismi hangisidir?', 'Dünya', 'Jüpiter', 'Güneş', 'Satürn', 'C', 'Easy'),

(1, 'Atomun çekirdeğinde bulunan temel parçacıklardan biri aşağıdakilerden hangisidir?', 'Elektron', 'Proton', 'Foton', 'Nötrino', 'B', 'Medium'),
(1, 'pH değeri 7 olan saf su, 25 °C sıcaklıkta hangi özelliğe sahiptir?', 'Asidik', 'Bazik', 'Nötr', 'Radyoaktif', 'C', 'Medium'),
(1, 'Newton''un ikinci hareket yasasına göre bir cismin net kuvveti, kütlesi ve ivmesi arasındaki ilişki hangisidir?', 'F = m × a', 'F = m / a', 'F = a / m', 'F = m + a', 'A', 'Medium'),
(1, 'DNA''nın yapısında bulunan ve genetik bilgiyi taşıyan temel birimler hangileridir?', 'Amino asitler', 'Nükleotitler', 'Yağ asitleri', 'Monosakkaritler', 'B', 'Medium'),
(1, 'Dünya''nın atmosferinde ozon tabakasının en yoğun bulunduğu atmosfer katmanı hangisidir?', 'Troposfer', 'Stratosfer', 'Mezosfer', 'Termosfer', 'B', 'Medium'),

(1, 'Bir yıldızın yaşamının sonunda oluşabilecek nötron yıldızı, esas olarak hangi maddeden oluşur?', 'Katı demir kristallerinden', 'Nötronca zengin aşırı yoğun maddeden', 'Saf hidrojenden', 'Sıvı helyumdan', 'B', 'Hard'),
(1, 'Heisenberg''in belirsizlik ilkesine göre aşağıdakilerden hangisi aynı anda keyfi hassasiyetle belirlenemez?', 'Bir elektronun yükü ve spini', 'Bir elektronun konumu ve momentumu', 'Bir atomun proton sayısı ve nötron sayısı', 'Bir fotonun enerjisi ve frekansı', 'B', 'Hard'),
(1, 'Bir enzimin katalizlediği kimyasal tepkimede enzimin temel işlevi aşağıdakilerden hangisidir?', 'Tepkimenin denge sabitini değiştirmek', 'Ürünlerin toplam enerjisini artırmak', 'Aktivasyon enerjisini düşürmek', 'Tepkimeyi termodinamik olarak mümkün hâle getirmek', 'C', 'Hard'),

(1, 'Standart Model''e göre aşağıdaki parçacıklardan hangisi güçlü nükleer etkileşime doğrudan katılan temel parçacıklardan biridir?', 'Elektron', 'Foton', 'Gluon', 'Nötrino', 'C', 'Very Hard'),
(1, 'Termodinamiğin ikinci yasasına göre yalıtılmış bir sistemde aşağıdaki büyüklüklerden hangisinin zamanla azalması beklenmez?', 'Toplam enerji', 'Entropi', 'Sıcaklık', 'İç enerji', 'B', 'Very Hard'),
-- History (Tarih)
(2, 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?', '23 Nisan 1920', '29 Ekim 1923', '19 Mayıs 1919', '30 Ağustos 1922', 'B', 'Easy'),
(2, 'İstanbul hangi Osmanlı padişahı döneminde fethedilmiştir?', 'I. Murad', 'Yıldırım Bayezid', 'II. Mehmed', 'Kanuni Sultan Süleyman', 'C', 'Easy'),
(2, 'Türkiye Büyük Millet Meclisi hangi tarihte açılmıştır?', '19 Mayıs 1919', '23 Nisan 1920', '29 Ekim 1923', '30 Ağustos 1922', 'B', 'Easy'),
(2, 'Mustafa Kemal Atatürk''ün Samsun''a çıktığı tarih hangisidir?', '23 Nisan 1920', '19 Mayıs 1919', '10 Kasım 1938', '29 Ekim 1923', 'B', 'Easy'),
(2, 'Osmanlı Devleti''nin kurucusu olarak kabul edilen kişi kimdir?', 'Osman Gazi', 'Orhan Gazi', 'I. Murad', 'Yıldırım Bayezid', 'A', 'Easy'),
(2, 'Malazgirt Savaşı hangi yıl gerçekleşmiştir?', '1071', '1176', '1453', '1517', 'A', 'Easy'),
(2, 'Fransız İhtilali hangi yıl başlamıştır?', '1688', '1776', '1789', '1815', 'C', 'Easy'),
(2, 'Kurtuluş Savaşı''nda Yunan ordusuna karşı kazanılan kesin zaferi simgeleyen Büyük Taarruz hangi yıl gerçekleşmiştir?', '1919', '1920', '1921', '1922', 'D', 'Easy'),
(2, 'Osmanlı Devleti''nde Tanzimat Fermanı hangi padişah döneminde ilan edilmiştir?', 'II. Mahmud', 'Abdülmecid', 'Abdülaziz', 'II. Abdülhamid', 'B', 'Easy'),
(2, 'Birinci Dünya Savaşı hangi yıl başlamıştır?', '1912', '1914', '1916', '1918', 'B', 'Easy'),

(2, 'Lozan Barış Antlaşması hangi yıl imzalanmıştır?', '1920', '1921', '1923', '1925', 'C', 'Medium'),
(2, 'Osmanlı Devleti''nde Yeniçeri Ocağı hangi padişah döneminde kaldırılmıştır?', 'III. Selim', 'II. Mahmud', 'Abdülmecid', 'II. Abdülhamid', 'B', 'Medium'),
(2, 'Kadeş Antlaşması esas olarak hangi iki devlet arasında imzalanmıştır?', 'Roma ve Kartaca', 'Mısır ve Hititler', 'Persler ve Yunanlar', 'Bizans ve Sasani İmparatorluğu', 'B', 'Medium'),
(2, 'Berlin Duvarı hangi yıl yıkılmıştır?', '1975', '1981', '1989', '1991', 'C', 'Medium'),
(2, 'Türkiye Cumhuriyeti''nde kadınlara milletvekili seçme ve seçilme hakkı hangi yıl verilmiştir?', '1926', '1930', '1934', '1938', 'C', 'Medium'),

(2, 'Osmanlı Devleti''nde ilk Osmanlı matbaasını kuran kişilerden biri olan İbrahim Müteferrika''nın matbaası hangi padişah döneminde faaliyete başlamıştır?', 'III. Ahmed', 'I. Mahmud', 'III. Mustafa', 'I. Abdülhamid', 'A', 'Hard'),
(2, 'Westphalia Barışı hangi savaşın sona ermesiyle ilişkilendirilir?', 'Yedi Yıl Savaşı', 'Otuz Yıl Savaşı', 'Yüz Yıl Savaşı', 'İspanya Veraset Savaşı', 'B', 'Hard'),
(2, 'Bizans İmparatorluğu''nun son imparatoru kimdir?', 'I. Justinianus', 'II. Basileios', 'XI. Konstantinos', 'I. Aleksios', 'C', 'Hard'),

(2, 'Osmanlı Devleti''nin Avrupa''daki ilk sürekli elçiliği hangi padişah döneminde açılmıştır?', 'III. Ahmed', 'III. Selim', 'II. Mahmud', 'Abdülmecid', 'B', 'Very Hard'),
(2, 'Napolyon Bonapart''ın Mısır Seferi''nin ardından Osmanlı Devleti ile Fransa arasında imzalanan ve Osmanlı''nın Fransa''ya karşı Rusya ve İngiltere ile ittifak yapmasına yol açan antlaşma hangisidir?', 'Küçük Kaynarca Antlaşması', 'Yaş Antlaşması', 'Paris Antlaşması', 'Ziştovi Antlaşması', 'C', 'Very Hard'),
-- Geography (Coğrafya)

(3, 'Dünya''nın en büyük kıtası hangisidir?', 'Afrika', 'Asya', 'Avrupa', 'Kuzey Amerika', 'B', 'Easy'),
(3, 'Türkiye''nin başkenti neresidir?', 'İstanbul', 'İzmir', 'Ankara', 'Bursa', 'C', 'Easy'),
(3, 'Dünya''nın en büyük okyanusu hangisidir?', 'Atlas Okyanusu', 'Hint Okyanusu', 'Arktik Okyanusu', 'Pasifik Okyanusu', 'D', 'Easy'),
(3, 'Nil Nehri hangi kıtada bulunur?', 'Asya', 'Afrika', 'Avrupa', 'Güney Amerika', 'B', 'Easy'),
(3, 'Türkiye''nin en uzun kıyı şeridine sahip denizi hangisidir?', 'Karadeniz', 'Marmara Denizi', 'Akdeniz', 'Ege Denizi', 'C', 'Easy'),
(3, 'Dünya''nın en yüksek dağı hangisidir?', 'K2', 'Everest', 'Kilimanjaro', 'Elbruz', 'B', 'Easy'),
(3, 'Sahra Çölü hangi kıtada yer alır?', 'Asya', 'Afrika', 'Avustralya', 'Güney Amerika', 'B', 'Easy'),
(3, 'Ekvator, Dünya''yı hangi iki yarım küreye ayırır?', 'Doğu ve Batı', 'Kuzey ve Güney', 'Kara ve Deniz', 'Tropikal ve Kutupsal', 'B', 'Easy'),
(3, 'İtalya''nın başkenti aşağıdakilerden hangisidir?', 'Milano', 'Venedik', 'Roma', 'Napoli', 'C', 'Easy'),
(3, 'Türkiye''nin yüz ölçümü bakımından en büyük gölü hangisidir?', 'Tuz Gölü', 'Beyşehir Gölü', 'Van Gölü', 'İznik Gölü', 'C', 'Easy'),

(3, 'Türkiye''nin en yüksek dağı hangisidir?', 'Erciyes Dağı', 'Süphan Dağı', 'Ağrı Dağı', 'Kaçkar Dağları', 'C', 'Medium'),
(3, 'Akdeniz ile Atlas Okyanusu''nu birbirine bağlayan boğaz hangisidir?', 'Hürmüz Boğazı', 'Bering Boğazı', 'Cebelitarık Boğazı', 'Malakka Boğazı', 'C', 'Medium'),
(3, 'Amazon Nehri hangi kıtada yer alır?', 'Afrika', 'Asya', 'Güney Amerika', 'Kuzey Amerika', 'C', 'Medium'),
(3, 'Türkiye''de yüz ölçümü bakımından en küçük coğrafi bölge hangisidir?', 'Marmara Bölgesi', 'Ege Bölgesi', 'Güneydoğu Anadolu Bölgesi', 'Karadeniz Bölgesi', 'C', 'Medium'),
(3, 'Dünya''nın en derin gölü olarak kabul edilen Baykal Gölü hangi ülkededir?', 'Kazakistan', 'Rusya', 'Moğolistan', 'Çin', 'B', 'Medium'),

(3, 'Türkiye''de iki kıta arasında yer alan ve İstanbul Boğazı ile Çanakkale Boğazı''nı bünyesinde barındıran deniz hangisidir?', 'Karadeniz', 'Ege Denizi', 'Marmara Denizi', 'Akdeniz', 'C', 'Hard'),
(3, 'Dünya''nın en büyük sıcak çölü olan Sahra Çölü yaklaşık olarak hangi kıtanın kuzey bölümünün büyük kısmını kaplar?', 'Afrika', 'Asya', 'Avustralya', 'Güney Amerika', 'A', 'Hard'),
(3, 'And Dağları hangi iki coğrafi uç arasında uzanan Güney Amerika''nın batı kıyısı boyunca yer alır?', 'Karayip Denizi ile Atlas Okyanusu', 'Panama''dan Tierra del Fuego''ya', 'Amazon Havzası ile Brezilya Platosu', 'Ekvador''dan Galapagos Adaları''na', 'B', 'Hard'),

(3, 'Dünya üzerindeki en uzun kara sınırını hangi iki ülke paylaşır?', 'Rusya ve Kazakistan', 'ABD ve Kanada', 'Çin ve Moğolistan', 'Arjantin ve Şili', 'B', 'Very Hard'),
(3, 'Hangi ülke hem Atlas Okyanusu''na hem de Akdeniz''e kıyısı bulunan ve Cebelitarık Boğazı''nın Avrupa tarafında yer alan ülkedir?', 'İspanya', 'Portekiz', 'İtalya', 'Fransa', 'A', 'Very Hard'),

-- Sports (Spor)

(4, 'Futbolda bir takım sahada kaç oyuncuyla oynar?', '9', '10', '11', '12', 'C', 'Easy'),
(4, 'Olimpiyat Oyunları''nda beş halkalı sembol kaç halkadan oluşur?', '4', '5', '6', '7', 'B', 'Easy'),
(4, 'Basketbolda serbest atış başarılı olduğunda kaç sayı kazandırır?', '1', '2', '3', '4', 'A', 'Easy'),
(4, 'Teniste sıfır puanı ifade etmek için hangi terim kullanılır?', 'Love', 'Ace', 'Deuce', 'Fault', 'A', 'Easy'),
(4, 'Voleybolda bir takım sahada aynı anda kaç oyuncuyla yer alır?', '5', '6', '7', '8', 'B', 'Easy'),
(4, 'Futbolda topun tamamının kale çizgisini geçmesi durumunda hangi sonuç oluşur?', 'Korner', 'Taç', 'Gol', 'Ofsayt', 'C', 'Easy'),
(4, 'Formula 1 yarışlarında damalı bayrak neyi ifade eder?', 'Yarışın başladığını', 'Güvenlik aracının çıktığını', 'Yarışın sona erdiğini', 'Pit yolunun kapandığını', 'C', 'Easy'),
(4, 'Boks müsabakasında sporcuların kullandığı temel ekipman hangisidir?', 'Raket', 'Eldiven', 'Sopa', 'Kask', 'B', 'Easy'),
(4, 'Maraton yarışının resmi uzunluğu yaklaşık kaç kilometredir?', '21,1 km', '30 km', '42,195 km', '50 km', 'C', 'Easy'),
(4, 'Satrançta oyunun başında her oyuncunun kaç taşı bulunur?', '12', '14', '16', '18', 'C', 'Easy'),

(4, 'Futbolda bir oyuncunun aynı maçta üç gol atmasına ne ad verilir?', 'Hat-trick', 'Duble', 'Asist', 'Clean sheet', 'A', 'Medium'),
(4, 'Basketbolda üç sayı çizgisinin gerisinden yapılan başarılı bir atış kaç sayı değerindedir?', '1', '2', '3', '4', 'C', 'Medium'),
(4, 'Olimpiyat Oyunları''nda yüzme yarışları hangi spor dalının bir parçasıdır?', 'Su topu', 'Atletizm', 'Yüzme', 'Kürek', 'C', 'Medium'),
(4, 'Teniste bir sette 6-6 eşitlik oluştuğunda çoğu standart sette oynanan karar oyununun adı nedir?', 'Tie-break', 'Golden set', 'Sudden death', 'Match point', 'A', 'Medium'),
(4, 'Futbolda bir oyuncunun rakibine yaptığı ciddi kural ihlali sonucunda doğrudan hangi kartla oyundan ihraç edilebilir?', 'Beyaz kart', 'Sarı kart', 'Turuncu kart', 'Kırmızı kart', 'D', 'Medium'),

(4, 'Modern Olimpiyat Oyunları''nda erkekler 100 metre dünya rekorunu 9,58 saniyelik dereceyle kıran atlet kimdir?', 'Carl Lewis', 'Usain Bolt', 'Michael Johnson', 'Mo Farah', 'B', 'Hard'),
(4, 'Basketbolda NBA''de bir takımın normal oyun süresi, dört çeyreğin her biri 12 dakika olduğuna göre toplam kaç dakikadır?', '36', '40', '48', '60', 'C', 'Hard'),
(4, 'Formula 1''de bir yarış hafta sonunda sıralama turlarının temel amacı nedir?', 'En hızlı turu atan sürücünün yarışa ilk sıradan başlamasını belirlemek', 'Yarışın toplam tur sayısını belirlemek', 'Pit stop sayısını zorunlu olarak belirlemek', 'Yarışın kazananını yarıştan önce belirlemek', 'A', 'Hard'),

(4, 'Satrançta yalnızca şah ve kale ile rakip şahı mat etmek için kullanılan temel teknik aşağıdakilerden hangisidir?', 'Çatal', 'Merdiven matı', 'Şiş', 'Çifte saldırı', 'B', 'Very Hard'),
(4, 'Atletizmde dekatlon yarışmasında sporcular toplam kaç farklı branşta mücadele eder?', '8', '9', '10', '12', 'C', 'Very Hard'),

-- Art (Sanat)

(5, 'Leonardo da Vinci''nin en ünlü tablolarından biri aşağıdakilerden hangisidir?', 'Yıldızlı Gece', 'Mona Lisa', 'Çığlık', 'İnci Küpeli Kız', 'B', 'Easy'),
(5, 'Vincent van Gogh''un ünlü tablolarından biri aşağıdakilerden hangisidir?', 'Yıldızlı Gece', 'Guernica', 'Son Akşam Yemeği', 'Belleğin Azmi', 'A', 'Easy'),
(5, 'Pablo Picasso''nun savaşın yıkımını konu alan ünlü eseri hangisidir?', 'Guernica', 'Mona Lisa', 'Venüs''ün Doğuşu', 'Düşünür', 'A', 'Easy'),
(5, 'Michelangelo''nun Sistine Şapeli''nin tavanına yaptığı ünlü eser hangi sanat dalına aittir?', 'Heykel', 'Mimari', 'Fresk', 'Seramik', 'C', 'Easy'),
(5, 'Osman Hamdi Bey''in en tanınmış tablolarından biri aşağıdakilerden hangisidir?', 'Kaplumbağa Terbiyecisi', 'Çığlık', 'İnci Küpeli Kız', 'Arşidük Ferdinand''ın Portresi', 'A', 'Easy'),
(5, 'Heykel sanatında üç boyutlu eser oluşturmak için aşağıdaki malzemelerden hangisi yaygın olarak kullanılır?', 'Mermer', 'Kağıt', 'Mürekkep', 'Suluboya', 'A', 'Easy'),
(5, 'Resimde renkleri bir yüzeye uygulamak için kullanılan temel araçlardan biri hangisidir?', 'Fırça', 'Keski', 'Keman yayı', 'Pergel', 'A', 'Easy'),
(5, 'Auguste Rodin''in en tanınmış heykellerinden biri hangisidir?', 'Düşünen Adam', 'Davud', 'Diskobol', 'Kanatlı Zafer', 'A', 'Easy'),
(5, 'Salvador Dalí''nin eriyen saatleriyle tanınan eseri hangisidir?', 'Belleğin Azmi', 'Guernica', 'Öpücük', 'Kırmızı Balon', 'A', 'Easy'),
(5, 'Edvard Munch''un en tanınmış eserlerinden biri aşağıdakilerden hangisidir?', 'Çığlık', 'Mona Lisa', 'Gece Kuşları', 'Su Zambakları', 'A', 'Easy'),

(5, 'Claude Monet hangi sanat akımının öncülerinden biri olarak kabul edilir?', 'Kübizm', 'Empresyonizm', 'Sürrealizm', 'Ekspresyonizm', 'B', 'Medium'),
(5, 'Gustav Klimt''in en tanınmış tablolarından biri aşağıdakilerden hangisidir?', 'Öpücük', 'Çığlık', 'Guernica', 'Kaplumbağa Terbiyecisi', 'A', 'Medium'),
(5, 'Piet Mondrian''ın geometrik şekiller ve ana renklerle oluşturduğu eserler hangi sanat anlayışıyla ilişkilidir?', 'Sembolizm', 'De Stijl', 'Barok', 'Rokoko', 'B', 'Medium'),
(5, 'Rönesans sanatının ortaya çıkışında önemli rol oynayan şehir aşağıdakilerden hangisidir?', 'Floransa', 'Londra', 'Moskova', 'Oslo', 'A', 'Medium'),
(5, 'Barok sanatında genellikle hangi özellik ön plana çıkar?', 'Hareket, dramatik ışık ve güçlü karşıtlıklar', 'Tamamen geometrik soyutlama', 'Sadece siyah-beyaz kullanım', 'Perspektifin tamamen reddedilmesi', 'A', 'Medium'),

(5, 'Fransız ressam Georges Seurat''ın küçük renk noktalarını yan yana kullanarak oluşturduğu teknik hangisidir?', 'Kolaj', 'Puantilizm', 'Gravür', 'Fresk', 'B', 'Hard'),
(5, 'Leonardo da Vinci''nin ''Son Akşam Yemeği'' adlı eseri hangi şehirdeki Santa Maria delle Grazie manastırının yemekhanesinde bulunmaktadır?', 'Roma', 'Floransa', 'Milano', 'Venedik', 'C', 'Hard'),
(5, 'Antik Yunan heykel sanatında ideal insan bedenini temsil eden ve günümüze Roma kopyalarıyla ulaşan ünlü heykellerden biri hangisidir?', 'Diskobol', 'Düşünen Adam', 'Öpücük', 'Kaplumbağa Terbiyecisi', 'A', 'Hard'),

(5, 'Caravaggio''nun eserlerinde ışık ve karanlık arasındaki dramatik karşıtlığı belirgin biçimde kullanması hangi teknik veya üslupla ilişkilendirilir?', 'Chiaroscuro', 'Puantilizm', 'Fütürizm', 'Kübizm', 'A', 'Very Hard'),
(5, 'Rönesans döneminde sanatçıların gerçekçi mekân ve derinlik oluşturmak için geliştirdiği doğrusal perspektifin sistematik kullanımında adı öne çıkan sanatçı kimdir?', 'Filippo Brunelleschi', 'Claude Monet', 'Edvard Munch', 'Jackson Pollock', 'A', 'Very Hard'),

-- Technology (Teknoloji)
(6, 'Bilgisayarın merkezi işlem biriminin kısaltması aşağıdakilerden hangisidir?', 'RAM', 'CPU', 'GPU', 'SSD', 'B', 'Easy'),
(6, 'İnternette web sayfalarını görüntülemek için kullanılan yazılıma ne ad verilir?', 'Derleyici', 'Tarayıcı', 'İşletim sistemi', 'Veritabanı', 'B', 'Easy'),
(6, 'Aşağıdakilerden hangisi bir işletim sistemidir?', 'Linux', 'HTML', 'SQL', 'HTTP', 'A', 'Easy'),
(6, 'Bilgisayarlarda geçici verileri hızlı bir şekilde saklayan bellek türü hangisidir?', 'RAM', 'HDD', 'DVD', 'ROM', 'A', 'Easy'),
(6, 'Bir web sitesinin adresini belirtmek için kullanılan kısaltma aşağıdakilerden hangisidir?', 'URL', 'CPU', 'USB', 'PDF', 'A', 'Easy'),
(6, 'USB bağlantı noktalarının temel kullanım amaçlarından biri aşağıdakilerden hangisidir?', 'Cihazlar arasında veri aktarımı', 'Ekran çözünürlüğünü artırmak', 'İşlemciyi soğutmak', 'İşletim sistemini otomatik olarak değiştirmek', 'A', 'Easy'),
(6, 'Aşağıdakilerden hangisi bir programlama dilidir?', 'Python', 'HTML', 'JPEG', 'HTTP', 'A', 'Easy'),
(6, 'Bir bilgisayarda dosyaları kalıcı olarak saklamak için kullanılan donanımlardan biri hangisidir?', 'RAM', 'SSD', 'CPU', 'GPU', 'B', 'Easy'),
(6, 'Yapay zekâ kavramı temel olarak aşağıdakilerden hangisini ifade eder?', 'Makinelerin insan benzeri görevleri gerçekleştirebilmesini sağlayan yöntem ve sistemleri', 'Bilgisayarların yalnızca internete bağlanmasını', 'Dosyaların sıkıştırılmasını', 'Elektrik devrelerinin fiziksel olarak küçültülmesini', 'A', 'Easy'),
(6, 'Bir bilgisayar ağında cihazların birbirleriyle iletişim kurmasını sağlayan kurallar bütününe ne ad verilir?', 'Protokol', 'Klasör', 'Sürücü', 'Ekran kartı', 'A', 'Easy'),

(6, 'DNS''nin temel görevi aşağıdakilerden hangisidir?', 'Alan adlarını IP adresleriyle eşleştirmek', 'Dosyaları şifrelemek', 'İşlemci hızını artırmak', 'Web sayfalarını görsel olarak tasarlamak', 'A', 'Medium'),
(6, 'Git aşağıdakilerden hangisidir?', 'Sürüm kontrol sistemi', 'Veritabanı yönetim sistemi', 'İşletim sistemi', 'Web tarayıcısı', 'A', 'Medium'),
(6, 'HTTPS''nin HTTP''den temel farkı aşağıdakilerden hangisidir?', 'İletişimin TLS ile şifrelenmesini sağlaması', 'Web sitelerinin daha fazla RAM kullanmasını sağlaması', 'Yalnızca mobil cihazlarda çalışması', 'İnternet bağlantısını tamamen ortadan kaldırması', 'A', 'Medium'),
(6, 'SQL temel olarak hangi amaçla kullanılır?', 'İlişkisel veritabanlarındaki verileri yönetmek ve sorgulamak', 'Görüntüleri düzenlemek', 'İşletim sistemi geliştirmek', 'Bilgisayar donanımı üretmek', 'A', 'Medium'),
(6, 'IPv4 adresleri kaç bit uzunluğundadır?', '16', '32', '64', '128', 'B', 'Medium'),

(6, 'Bir programın kaynak kodunu çalıştırılabilir makine koduna çeviren yazılıma ne ad verilir?', 'Derleyici', 'Tarayıcı', 'Metin düzenleyici', 'Dosya yöneticisi', 'A', 'Hard'),
(6, 'Nesne yönelimli programlamada bir sınıftan oluşturulan somut örneğe ne ad verilir?', 'Modül', 'İş parçacığı', 'Nesne', 'Derleyici', 'C', 'Hard'),
(6, 'REST mimarisinde istemci ile sunucu arasındaki durum bilgisinin istekler arasında sunucu tarafından tutulmaması hangi özelliği ifade eder?', 'Önbellekleme', 'Durumsuzluk', 'Şifreleme', 'Yönlendirme', 'B', 'Hard'),

(6, 'Bilgisayar biliminde ''halting problem'' aşağıdaki sorulardan hangisini genel olarak ele alır?', 'Bir programın verilen girdide durup durmayacağının genel bir algoritmayla belirlenip belirlenemeyeceğini', 'Bir işlemcinin maksimum saat hızını', 'Bir ağ paketinin hangi yönlendiriciden geçeceğini', 'Bir dosyanın ne kadar depolama alanı kaplayacağını', 'A', 'Very Hard'),
(6, 'CAP teoremine göre dağıtık bir sistem, ağ bölünmesi gerçekleştiğinde aşağıdaki özelliklerden hangilerinin ikisini aynı anda garanti edebilir?', 'Tutarlılık ve kullanılabilirlik', 'Gecikme ve bant genişliği', 'Şifreleme ve sıkıştırma', 'Yedeklilik ve sanallaştırma', 'A', 'Very Hard'),

-- Literature (Edebiyat)

(7, 'İstiklal Marşı''nın şairi kimdir?', 'Yahya Kemal Beyatlı', 'Mehmet Akif Ersoy', 'Tevfik Fikret', 'Nazım Hikmet', 'B', 'Easy'),
(7, '''Sefiller'' adlı romanın yazarı kimdir?', 'Victor Hugo', 'Dostoyevski', 'Tolstoy', 'Charles Dickens', 'A', 'Easy'),
(7, '''Don Kişot'' adlı eserin yazarı kimdir?', 'William Shakespeare', 'Miguel de Cervantes', 'Goethe', 'Dante Alighieri', 'B', 'Easy'),
(7, '''Romeo ve Juliet'' adlı eserin yazarı kimdir?', 'William Shakespeare', 'Victor Hugo', 'Molière', 'Homer', 'A', 'Easy'),
(7, 'Türk edebiyatında ''İnce Memed'' romanının yazarı kimdir?', 'Orhan Kemal', 'Yaşar Kemal', 'Kemal Tahir', 'Sabahattin Ali', 'B', 'Easy'),
(7, '''Suç ve Ceza'' adlı romanın yazarı kimdir?', 'Fyodor Dostoyevski', 'Lev Tolstoy', 'Anton Çehov', 'Nikolay Gogol', 'A', 'Easy'),
(7, '''Kürk Mantolu Madonna'' adlı romanın yazarı kimdir?', 'Sabahattin Ali', 'Sait Faik Abasıyanık', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'A', 'Easy'),
(7, '''Çalıkuşu'' romanının yazarı kimdir?', 'Halide Edib Adıvar', 'Reşat Nuri Güntekin', 'Yakup Kadri Karaosmanoğlu', 'Refik Halit Karay', 'B', 'Easy'),
(7, '''Dönüşüm'' adlı eserin yazarı kimdir?', 'Franz Kafka', 'Albert Camus', 'George Orwell', 'Ernest Hemingway', 'A', 'Easy'),
(7, '''1984'' adlı distopik romanın yazarı kimdir?', 'Aldous Huxley', 'George Orwell', 'Ray Bradbury', 'Jules Verne', 'B', 'Easy'),

(7, '''Tutunamayanlar'' romanının yazarı kimdir?', 'Oğuz Atay', 'Orhan Pamuk', 'Yusuf Atılgan', 'Tarık Buğra', 'A', 'Medium'),
(7, '''Saatleri Ayarlama Enstitüsü'' adlı romanın yazarı kimdir?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Ahmet Mithat Efendi', 'Hüseyin Rahmi Gürpınar', 'A', 'Medium'),
(7, '''Mai ve Siyah'' romanı aşağıdaki yazarlardan hangisine aittir?', 'Halit Ziya Uşaklıgil', 'Mehmet Rauf', 'Tevfik Fikret', 'Samipaşazade Sezai', 'A', 'Medium'),
(7, '''Aşk-ı Memnu'' romanının yazarı kimdir?', 'Halit Ziya Uşaklıgil', 'Recaizade Mahmut Ekrem', 'Namık Kemal', 'Şemsettin Sami', 'A', 'Medium'),
(7, 'Dünya edebiyatında ''İlahi Komedya'' adlı eserin yazarı kimdir?', 'Dante Alighieri', 'Homeros', 'Virgil', 'Boccaccio', 'A', 'Medium'),

(7, 'Türk edebiyatında ''Taaşşuk-ı Talat ve Fitnat'' hangi yazarın eseridir?', 'Şemsettin Sami', 'Namık Kemal', 'Ziya Paşa', 'Ahmet Mithat Efendi', 'A', 'Hard'),
(7, '''Eylül'' adlı roman, Türk edebiyatında genellikle hangi özelliğiyle öne çıkar?', 'İlk psikolojik roman olarak kabul edilmesi', 'İlk köy romanı olması', 'İlk tarihi roman olması', 'İlk polisiye roman olması', 'A', 'Hard'),
(7, '''Huzur'' romanında Mümtaz karakterinin iç dünyası ve İstanbul''un kültürel atmosferi hangi yazarın anlatımıyla işlenmiştir?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Yakup Kadri Karaosmanoğlu', 'Necip Fazıl Kısakürek', 'A', 'Hard'),

(7, 'Dede Korkut Hikâyeleri''nin bilinen Dresden ve Vatikan nüshaları hangi Türk edebiyatı döneminin sözlü ve yazılı geleneklerini yansıtır?', 'İslamiyet öncesi Türk edebiyatı', 'Geçiş dönemi Türk edebiyatı', 'İslamiyet sonrası Türk destan geleneği', 'Tanzimat Dönemi Türk edebiyatı', 'C', 'Very Hard'),
(7, '''Kutadgu Bilig'' adlı eserin yazarı kimdir?', 'Kaşgarlı Mahmud', 'Yusuf Has Hacip', 'Edip Ahmet Yükneki', 'Ahmet Yesevi', 'B', 'Very Hard'),

-- Music (Müzik)

(8, 'Piyanoda kaç beyaz tuş bulunur?', '44', '52', '61', '88', 'B', 'Easy'),
(8, 'Bir orkestrada yaylı çalgılardan biri aşağıdakilerden hangisidir?', 'Keman', 'Trompet', 'Flüt', 'Klarnet', 'A', 'Easy'),
(8, 'Müzikte seslerin belirli bir düzen içinde sıralanmasına ne ad verilir?', 'Ritim', 'Melodi', 'Tempo', 'Tını', 'B', 'Easy'),
(8, 'Aşağıdakilerden hangisi vurmalı bir çalgıdır?', 'Keman', 'Piyano', 'Davul', 'Flüt', 'C', 'Easy'),
(8, 'Müzikte bir eserin hızını belirten terim aşağıdakilerden hangisidir?', 'Tempo', 'Tını', 'Armoni', 'Akor', 'A', 'Easy'),
(8, 'Bağlama hangi çalgı ailesine aittir?', 'Yaylı çalgılar', 'Telli çalgılar', 'Üflemeli çalgılar', 'Vurmalı çalgılar', 'B', 'Easy'),
(8, 'Türk halk müziğinde ''uzun hava'' genel olarak hangi özelliğiyle tanınır?', 'Serbest ritimli olması', 'Yalnızca davulla çalınması', 'Sadece enstrümantal olması', 'Çok hızlı tempoda söylenmesi', 'A', 'Easy'),
(8, 'Müzikte iki veya daha fazla sesin aynı anda duyulmasıyla oluşan yapıya ne ad verilir?', 'Akor', 'Tempo', 'Ritim', 'Nota', 'A', 'Easy'),
(8, 'Ludwig van Beethoven hangi ülkenin Bonn şehrinde doğmuştur?', 'Almanya', 'İtalya', 'Avusturya', 'Fransa', 'A', 'Easy'),
(8, 'Wolfgang Amadeus Mozart hangi sanat dalında tanınmış bir bestecidir?', 'Resim', 'Heykel', 'Müzik', 'Mimari', 'C', 'Easy'),

(8, 'Bir müzik eserinin ses yüksekliğinin giderek artmasına ne ad verilir?', 'Diminuendo', 'Crescendo', 'Staccato', 'Legato', 'B', 'Medium'),
(8, 'Aşağıdakilerden hangisi üflemeli bir çalgıdır?', 'Viyolonsel', 'Obua', 'Kontrbas', 'Timpani', 'B', 'Medium'),
(8, 'Bir oktav kaç doğal nota içerir?', '5', '6', '7', '8', 'C', 'Medium'),
(8, 'Johann Sebastian Bach hangi müzik döneminin önemli bestecilerinden biridir?', 'Barok', 'Klasik', 'Romantik', 'Empresyonist', 'A', 'Medium'),
(8, 'Müzikte ''forte'' terimi neyi ifade eder?', 'Yavaş çalmayı', 'Güçlü ve yüksek sesle çalmayı', 'Hızlı çalmayı', 'Kesik çalmayı', 'B', 'Medium'),

(8, 'Bir senfonik orkestrada yaylı çalgılar ailesinin en kalın sesli standart üyesi hangisidir?', 'Viyola', 'Viyolonsel', 'Kontrbas', 'Keman', 'C', 'Hard'),
(8, 'Antonio Vivaldi''nin en tanınmış eserlerinden biri olan ''Dört Mevsim'' hangi türde bestelenmiştir?', 'Konçerto', 'Opera', 'Senfoni', 'Oratoryo', 'A', 'Hard'),
(8, 'Müzikte bir temanın farklı ses yüksekliklerinde art arda tekrarlanmasına dayanan kontrpuan tekniği aşağıdakilerden hangisidir?', 'Füg', 'Rondo', 'Sonat', 'Arya', 'A', 'Hard'),

(8, 'Batı müziğinde bir majör dizinin üçüncü derecesinin bemol yapılmasıyla oluşan dizi aşağıdakilerden hangisidir?', 'Doğal minör dizi', 'Armonik minör dizi', 'Melodik minör dizi', 'Pentatonik dizi', 'A', 'Very Hard'),
(8, 'Bir müzik eserinde ana tonalitenin dışında geçici olarak başka bir tonalite merkezinin öne çıkmasına ne ad verilir?', 'Modülasyon', 'Senkop', 'Artikülasyon', 'Polifoni', 'A', 'Very Hard'),

-- Movies (Sinema)
(9, 'Titanic filminin yönetmeni kimdir?', 'Steven Spielberg', 'James Cameron', 'Christopher Nolan', 'Ridley Scott', 'B', 'Easy'),
(9, 'The Godfather filminin yönetmeni kimdir?', 'Martin Scorsese', 'Francis Ford Coppola', 'Quentin Tarantino', 'Stanley Kubrick', 'B', 'Easy'),
(9, 'Harry Potter film serisinde Harry Potter karakterini kim canlandırmıştır?', 'Daniel Radcliffe', 'Rupert Grint', 'Tom Felton', 'Elijah Wood', 'A', 'Easy'),
(9, 'The Lord of the Rings film üçlemesinde Frodo Baggins karakterini kim canlandırmıştır?', 'Orlando Bloom', 'Ian McKellen', 'Elijah Wood', 'Viggo Mortensen', 'C', 'Easy'),
(9, 'Jurassic Park filminde temel olarak hangi canlıların yeniden hayata döndürülmesi konu edilir?', 'Mamutlar', 'Dinozorlar', 'Dev köpekbalıkları', 'Ejderhalar', 'B', 'Easy'),
(9, 'Toy Story filmi hangi animasyon stüdyosu tarafından yapılmıştır?', 'DreamWorks Animation', 'Pixar', 'Studio Ghibli', 'Warner Bros. Animation', 'B', 'Easy'),
(9, 'Star Wars serisinde Darth Vader''ın oğlu kimdir?', 'Luke Skywalker', 'Han Solo', 'Obi-Wan Kenobi', 'Lando Calrissian', 'A', 'Easy'),
(9, 'Forrest Gump filminde başrol karakterini hangi oyuncu canlandırmıştır?', 'Tom Hanks', 'Brad Pitt', 'Tom Cruise', 'Robin Williams', 'A', 'Easy'),
(9, 'The Matrix filminde Neo karakterini kim canlandırmıştır?', 'Keanu Reeves', 'Christian Bale', 'Hugh Jackman', 'Matt Damon', 'A', 'Easy'),
(9, 'The Dark Knight filminde Batman karakterini kim canlandırmıştır?', 'Ben Affleck', 'Christian Bale', 'Michael Keaton', 'George Clooney', 'B', 'Easy'),

(9, 'Schindler''s List filminin yönetmeni kimdir?', 'Steven Spielberg', 'David Fincher', 'James Cameron', 'Peter Jackson', 'A', 'Medium'),
(9, 'Inception filminin yönetmeni kimdir?', 'Denis Villeneuve', 'Christopher Nolan', 'David Lynch', 'Tim Burton', 'B', 'Medium'),
(9, 'Pulp Fiction filminin yönetmeni kimdir?', 'Quentin Tarantino', 'Guy Ritchie', 'Martin Scorsese', 'Coen Kardeşler', 'A', 'Medium'),
(9, 'Parasite filmi hangi ülkenin yapımıdır?', 'Japonya', 'Çin', 'Güney Kore', 'Tayland', 'C', 'Medium'),
(9, 'The Silence of the Lambs filmindeki Hannibal Lecter karakterini hangi oyuncu canlandırmıştır?', 'Anthony Hopkins', 'Jack Nicholson', 'Gary Oldman', 'Mads Mikkelsen', 'A', 'Medium'),

(9, 'Akira Kurosawa''nın yönettiği ve 1954 yılında yayımlanan film hangisidir?', 'Rashomon', 'Yedi Samuray', 'Ran', 'Ikiru', 'B', 'Hard'),
(9, '2001: A Space Odyssey filminin yönetmeni kimdir?', 'Stanley Kubrick', 'Arthur C. Clarke', 'Ridley Scott', 'George Lucas', 'A', 'Hard'),
(9, 'The Good, the Bad and the Ugly filmi hangi sinema türünün klasik örneklerinden biridir?', 'Film noir', 'Spagetti western', 'Bilim kurgu', 'Müzikal', 'B', 'Hard'),

(9, 'Federico Fellini''nin yönettiği 8½ filmi ağırlıklı olarak hangi konu etrafında şekillenir?', 'Bir yönetmenin yaratıcı krizi ve film yapma süreci', 'Bir uzay savaşının başlaması', 'Bir dedektifin cinayet soruşturması', 'Bir savaş gemisinin yolculuğu', 'A', 'Very Hard'),
(9, 'Alfred Hitchcock''un Vertigo filminde baş karakter Scottie Ferguson''u hangi oyuncu canlandırmıştır?', 'James Stewart', 'Cary Grant', 'Gregory Peck', 'Humphrey Bogart', 'A', 'Very Hard'),


-- Game

(10, 'Minecraft oyununda temel yapı malzemelerinden biri olan odun elde etmek için hangi kaynak kullanılır?', 'Ağaç', 'Taş', 'Demir cevheri', 'Kum', 'A', 'Easy'),
(10, 'Super Mario karakterinin üzerinde bulunduğu oyun serisinin adı aşağıdakilerden hangisidir?', 'The Legend of Zelda', 'Super Mario', 'Donkey Kong', 'Kirby', 'B', 'Easy'),
(10, 'Tetris oyununda temel amaç aşağıdakilerden hangisidir?', 'Aynı renkteki dört taşı birleştirmek', 'Düşen blokları yatay çizgiler oluşturacak şekilde tamamlamak', 'Rakip karakterleri yenmek', 'Bir haritada gizli eşyaları bulmak', 'B', 'Easy'),
(10, 'The Legend of Zelda serisinin ana karakteri kimdir?', 'Mario', 'Link', 'Kirby', 'Samus', 'B', 'Easy'),
(10, 'Pokémon oyunlarında oyuncuların yakalayıp eğittiği yaratıklara ne ad verilir?', 'Digimon', 'Pokémon', 'Titans', 'Guardians', 'B', 'Easy'),
(10, 'Minecraft''ta oyunun temel dünyasında oyuncunun başlangıçta sahip olduğu karakter varsayılan olarak hangi isimle bilinir?', 'Alex', 'Steve', 'Herobrine', 'Notch', 'B', 'Easy'),
(10, 'Counter-Strike serisinde oyuncular temel olarak hangi iki takım arasında mücadele eder?', 'Askerler ve zombiler', 'Teröristler ve anti-teröristler', 'Robotlar ve insanlar', 'Polisler ve korsanlar', 'B', 'Easy'),
(10, 'Pac-Man oyununda oyuncunun temel amacı aşağıdakilerden hangisidir?', 'Labirentteki noktaları toplamak', 'Rakip oyuncuları vurmak', 'Bir şehir inşa etmek', 'Araç yarışı kazanmak', 'A', 'Easy'),
(10, 'The Sims serisinde oyuncular temel olarak neyi yönetir?', 'Bir futbol takımını', 'Sanal karakterlerin yaşamlarını', 'Bir uzay gemisini', 'Bir yarış arabasını', 'B', 'Easy'),
(10, 'FIFA serisi hangi spor dalını temel alan video oyunlarıyla tanınmıştır?', 'Basketbol', 'Tenis', 'Futbol', 'Beyzbol', 'C', 'Easy'),

(10, 'Dark Souls serisi özellikle hangi oyun özelliğiyle tanınır?', 'Çok düşük zorluk seviyesi', 'Zorlu mücadeleleri ve dikkat gerektiren oynanışı', 'Yalnızca bulmaca çözmeye dayanması', 'Sadece çevrim içi oynanabilmesi', 'B', 'Medium'),
(10, 'The Witcher 3: Wild Hunt oyununda oyuncunun kontrol ettiği ana karakter kimdir?', 'Arthur Morgan', 'Geralt of Rivia', 'Ezio Auditore', 'Kratos', 'B', 'Medium'),
(10, 'Grand Theft Auto V''de aşağıdaki karakterlerden hangisi oynanabilir ana karakterlerden biridir?', 'Trevor Philips', 'Joel Miller', 'Nathan Drake', 'Aloy', 'A', 'Medium'),
(10, 'Among Us oyununda oyuncuların arasına gizlice karışan ve görevleri sabote eden karakterlere ne ad verilir?', 'Avcılar', 'Impostorlar', 'Muhafızlar', 'Komutanlar', 'B', 'Medium'),
(10, 'Portal oyun serisinde oyuncunun çevrede hareket etmek için kullandığı temel araç hangisidir?', 'Portal Gun', 'Gravity Gun', 'BFG', 'Hidden Blade', 'A', 'Medium'),

(10, 'The Legend of Zelda: Ocarina of Time oyununda ana karakter Link''in kullandığı zaman yolculuğuyla ilişkili temel eşya hangisidir?', 'Master Sword', 'Ocarina of Time', 'Hylian Shield', 'Hookshot', 'B', 'Hard'),
(10, 'Half-Life serisinde Gordon Freeman''ın mesleği nedir?', 'Asker', 'Fizikçi', 'Gazeteci', 'Pilot', 'B', 'Hard'),
(10, 'World of Warcraft''ta oyuncuların seçebildiği karakter sınıflarından biri aşağıdakilerden hangisidir?', 'Paladin', 'Sentinel', 'Warden', 'Templar', 'A', 'Hard'),

(10, 'Valve tarafından geliştirilen ve oyuncuların ''GLaDOS'' adlı yapay zekâ ile karşı karşıya geldiği oyun serisi hangisidir?', 'Half-Life', 'Portal', 'Left 4 Dead', 'Dota', 'B', 'Very Hard'),
(10, '1980 yılında piyasaya çıkan ve video oyunlarının altın çağının önemli yapımlarından biri kabul edilen ''Adventure'' oyunu hangi platform için geliştirilmiştir?', 'Atari 2600', 'Nintendo Entertainment System', 'Commodore 64', 'Sega Mega Drive', 'A', 'Very Hard');
