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

INSERT INTO questions (category_id, language, question_text, option_a, option_b, option_c, option_d, correct_option, difficulty)
VALUES
-- Science (Bilim)

(1, 'tr', 'Suyun deniz seviyesindeki kaynama noktası kaç santigrat derecedir?', '0 °C', '50 °C', '100 °C', '150 °C', 'C', 'Easy'),
(1, 'en', 'What is the boiling point of water at sea level in degrees Celsius?', '0 °C', '50 °C', '100 °C', '150 °C', 'C', 'Easy'),
(1, 'es', '¿Cuál es el punto de ebullición del agua al nivel del mar en grados Celsius?', '0 °C', '50 °C', '100 °C', '150 °C', 'C', 'Easy'),

(1, 'tr', 'Dünya''nın doğal uydusunun adı nedir?', 'Mars', 'Ay', 'Venüs', 'Merkür', 'B', 'Easy'),
(1, 'en', 'What is the name of Earth''s natural satellite?', 'Mars', 'Moon', 'Venus', 'Mercury', 'B', 'Easy'),
(1, 'es', '¿Cuál es el nombre del satélite natural de la Tierra?', 'Marte', 'Luna', 'Venus', 'Mercurio', 'B', 'Easy'),

(1, 'tr', 'İnsan vücudunda kanı pompalayan organ hangisidir?', 'Akciğer', 'Karaciğer', 'Böbrek', 'Kalp', 'D', 'Easy'),
(1, 'en', 'Which organ pumps blood in the human body?', 'Lung', 'Liver', 'Kidney', 'Heart', 'D', 'Easy'),
(1, 'es', '¿Qué órgano bombea la sangre en el cuerpo humano?', 'Pulmón', 'Hígado', 'Riñón', 'Corazón', 'D', 'Easy'),

(1, 'tr', 'Bitkilerin güneş ışığını kullanarak besin üretmesine ne ad verilir?', 'Fotosentez', 'Solunum', 'Fermantasyon', 'Sindirim', 'A', 'Easy'),
(1, 'en', 'What is the process by which plants produce food using sunlight called?', 'Photosynthesis', 'Respiration', 'Fermentation', 'Digestion', 'A', 'Easy'),
(1, 'es', '¿Cómo se llama el proceso mediante el cual las plantas producen alimento utilizando la luz solar?', 'Fotosíntesis', 'Respiración', 'Fermentación', 'Digestión', 'A', 'Easy'),

(1, 'tr', 'Dünya''daki en yaygın gaz hangisidir?', 'Oksijen', 'Karbondioksit', 'Azot', 'Hidrojen', 'C', 'Easy'),
(1, 'en', 'What is the most abundant gas on Earth?', 'Oxygen', 'Carbon dioxide', 'Nitrogen', 'Hydrogen', 'C', 'Easy'),
(1, 'es', '¿Cuál es el gas más abundante en la Tierra?', 'Oxígeno', 'Dióxido de carbono', 'Nitrógeno', 'Hidrógeno', 'C', 'Easy'),

(1, 'tr', 'Bir maddenin katı hâlden sıvı hâle geçmesine ne ad verilir?', 'Donma', 'Erime', 'Buharlaşma', 'Yoğuşma', 'B', 'Easy'),
(1, 'en', 'What is the process of a substance changing from a solid to a liquid called?', 'Freezing', 'Melting', 'Evaporation', 'Condensation', 'B', 'Easy'),
(1, 'es', '¿Cómo se llama el proceso mediante el cual una sustancia pasa de un estado sólido a un estado líquido?', 'Congelación', 'Fusión', 'Evaporación', 'Condensación', 'B', 'Easy'),

(1, 'tr', 'İnsanlarda solunum sırasında akciğerlere alınan temel gaz hangisidir?', 'Azot', 'Helyum', 'Oksijen', 'Hidrojen', 'C', 'Easy'),
(1, 'en', 'Which gas is primarily taken into the lungs during respiration in humans?', 'Nitrogen', 'Helium', 'Oxygen', 'Hydrogen', 'C', 'Easy'),
(1, 'es', '¿Qué gas se introduce principalmente en los pulmones durante la respiración en los seres humanos?', 'Nitrógeno', 'Helio', 'Oxígeno', 'Hidrógeno', 'C', 'Easy'),

(1, 'tr', 'Elektrik akımının birimi aşağıdakilerden hangisidir?', 'Volt', 'Watt', 'Ohm', 'Amper', 'D', 'Easy'),
(1, 'en', 'Which of the following is the unit of electric current?', 'Volt', 'Watt', 'Ohm', 'Ampere', 'D', 'Easy'),
(1, 'es', '¿Cuál de las siguientes es la unidad de la corriente eléctrica?', 'Voltio', 'Vatio', 'Ohmio', 'Amperio', 'D', 'Easy'),

(1, 'tr', 'Yer çekimi kuvvetinin etkisiyle bir cismin Dünya''ya doğru hareket etmesine ne denir?', 'Yansıma', 'Düşme', 'Kırılma', 'Genleşme', 'B', 'Easy'),
(1, 'en', 'What is the motion of an object toward Earth due to the force of gravity called?', 'Reflection', 'Falling', 'Refraction', 'Expansion', 'B', 'Easy'),
(1, 'es', '¿Cómo se llama el movimiento de un objeto hacia la Tierra debido a la fuerza de gravedad?', 'Reflexión', 'Caída', 'Refracción', 'Expansión', 'B', 'Easy'),

(1, 'tr', 'Güneş Sistemi''nin merkezinde bulunan gök cismi hangisidir?', 'Dünya', 'Jüpiter', 'Güneş', 'Satürn', 'C', 'Easy'),
(1, 'en', 'Which celestial body is located at the center of the Solar System?', 'Earth', 'Jupiter', 'Sun', 'Saturn', 'C', 'Easy'),
(1, 'es', '¿Qué cuerpo celeste se encuentra en el centro del Sistema Solar?', 'Tierra', 'Júpiter', 'Sol', 'Saturno', 'C', 'Easy'),

(1, 'tr', 'Atomun çekirdeğinde bulunan temel parçacıklardan biri aşağıdakilerden hangisidir?', 'Elektron', 'Proton', 'Foton', 'Nötrino', 'B', 'Medium'),
(1, 'en', 'Which of the following is one of the fundamental particles found in the nucleus of an atom?', 'Electron', 'Proton', 'Photon', 'Neutrino', 'B', 'Medium'),
(1, 'es', '¿Cuál de las siguientes es una de las partículas fundamentales que se encuentran en el núcleo de un átomo?', 'Electrón', 'Protón', 'Fotón', 'Neutrino', 'B', 'Medium'),

(1, 'tr', 'pH değeri 7 olan saf su, 25 °C sıcaklıkta hangi özelliğe sahiptir?', 'Asidik', 'Bazik', 'Nötr', 'Radyoaktif', 'C', 'Medium'),
(1, 'en', 'What property does pure water with a pH of 7 have at 25 °C?', 'Acidic', 'Basic', 'Neutral', 'Radioactive', 'C', 'Medium'),
(1, 'es', '¿Qué propiedad tiene el agua pura con un pH de 7 a una temperatura de 25 °C?', 'Ácida', 'Básica', 'Neutra', 'Radiactiva', 'C', 'Medium'),

(1, 'tr', 'Newton''un ikinci hareket yasasına göre bir cismin net kuvveti, kütlesi ve ivmesi arasındaki ilişki hangisidir?', 'F = m × a', 'F = m / a', 'F = a / m', 'F = m + a', 'A', 'Medium'),
(1, 'en', 'According to Newton''s second law of motion, what is the relationship between an object''s net force, mass, and acceleration?', 'F = m × a', 'F = m / a', 'F = a / m', 'F = m + a', 'A', 'Medium'),
(1, 'es', 'Según la segunda ley del movimiento de Newton, ¿cuál es la relación entre la fuerza neta, la masa y la aceleración de un objeto?', 'F = m × a', 'F = m / a', 'F = a / m', 'F = m + a', 'A', 'Medium'),

(1, 'tr', 'DNA''nın yapısında bulunan ve genetik bilgiyi taşıyan temel birimler hangileridir?', 'Amino asitler', 'Nükleotitler', 'Yağ asitleri', 'Monosakkaritler', 'B', 'Medium'),
(1, 'en', 'What are the basic units found in the structure of DNA that carry genetic information?', 'Amino acids', 'Nucleotides', 'Fatty acids', 'Monosaccharides', 'B', 'Medium'),
(1, 'es', '¿Cuáles son las unidades básicas presentes en la estructura del ADN que transportan la información genética?', 'Aminoácidos', 'Nucleótidos', 'Ácidos grasos', 'Monosacáridos', 'B', 'Medium'),

(1, 'tr', 'Dünya''nın atmosferinde ozon tabakasının en yoğun bulunduğu atmosfer katmanı hangisidir?', 'Troposfer', 'Stratosfer', 'Mezosfer', 'Termosfer', 'B', 'Medium'),
(1, 'en', 'Which layer of Earth''s atmosphere contains the highest concentration of the ozone layer?', 'Troposphere', 'Stratosphere', 'Mesosphere', 'Thermosphere', 'B', 'Medium'),
(1, 'es', '¿Qué capa de la atmósfera de la Tierra contiene la mayor concentración de la capa de ozono?', 'Troposfera', 'Estratosfera', 'Mesosfera', 'Termosfera', 'B', 'Medium'),

(1, 'tr', 'Bir yıldızın yaşamının sonunda oluşabilecek nötron yıldızı, esas olarak hangi maddeden oluşur?', 'Katı demir kristallerinden', 'Nötronca zengin aşırı yoğun maddeden', 'Saf hidrojenden', 'Sıvı helyumdan', 'B', 'Hard'),
(1, 'en', 'A neutron star that can form at the end of a star''s life is primarily composed of what?', 'Solid iron crystals', 'Extremely dense neutron-rich matter', 'Pure hydrogen', 'Liquid helium', 'B', 'Hard'),
(1, 'es', '¿De qué está compuesta principalmente una estrella de neutrones que puede formarse al final de la vida de una estrella?', 'Cristales sólidos de hierro', 'Materia extremadamente densa rica en neutrones', 'Hidrógeno puro', 'Helio líquido', 'B', 'Hard'),

(1, 'tr', 'Heisenberg''in belirsizlik ilkesine göre aşağıdakilerden hangisi aynı anda keyfi hassasiyetle belirlenemez?', 'Bir elektronun yükü ve spini', 'Bir elektronun konumu ve momentumu', 'Bir atomun proton sayısı ve nötron sayısı', 'Bir fotonun enerjisi ve frekansı', 'B', 'Hard'),
(1, 'en', 'According to Heisenberg''s uncertainty principle, which of the following cannot be determined simultaneously with arbitrary precision?', 'An electron''s charge and spin', 'An electron''s position and momentum', 'An atom''s number of protons and neutrons', 'A photon''s energy and frequency', 'B', 'Hard'),
(1, 'es', 'Según el principio de incertidumbre de Heisenberg, ¿cuál de las siguientes no puede determinarse simultáneamente con una precisión arbitraria?', 'La carga y el espín de un electrón', 'La posición y el momento de un electrón', 'El número de protones y neutrones de un átomo', 'La energía y la frecuencia de un fotón', 'B', 'Hard'),

(1, 'tr', 'Bir enzimin katalizlediği kimyasal tepkimede enzimin temel işlevi aşağıdakilerden hangisidir?', 'Tepkimenin denge sabitini değiştirmek', 'Ürünlerin toplam enerjisini artırmak', 'Aktivasyon enerjisini düşürmek', 'Tepkimeyi termodinamik olarak mümkün hâle getirmek', 'C', 'Hard'),
(1, 'en', 'What is the primary function of an enzyme in a chemical reaction that it catalyzes?', 'To change the reaction''s equilibrium constant', 'To increase the total energy of the products', 'To lower the activation energy', 'To make the reaction thermodynamically possible', 'C', 'Hard'),
(1, 'es', '¿Cuál es la función principal de una enzima en una reacción química que cataliza?', 'Cambiar la constante de equilibrio de la reacción', 'Aumentar la energía total de los productos', 'Disminuir la energía de activación', 'Hacer que la reacción sea termodinámicamente posible', 'C', 'Hard'),

(1, 'tr', 'Standart Model''e göre aşağıdaki parçacıklardan hangisi güçlü nükleer etkileşime doğrudan katılan temel parçacıklardan biridir?', 'Elektron', 'Foton', 'Gluon', 'Nötrino', 'C', 'Very Hard'),
(1, 'en', 'According to the Standard Model, which of the following particles is one of the fundamental particles that directly participates in the strong nuclear interaction?', 'Electron', 'Photon', 'Gluon', 'Neutrino', 'C', 'Very Hard'),
(1, 'es', 'Según el Modelo Estándar, ¿cuál de las siguientes partículas es una de las partículas fundamentales que participa directamente en la interacción nuclear fuerte?', 'Electrón', 'Fotón', 'Gluón', 'Neutrino', 'C', 'Very Hard'),

(1, 'tr', 'Termodinamiğin ikinci yasasına göre yalıtılmış bir sistemde aşağıdaki büyüklüklerden hangisinin zamanla azalması beklenmez?', 'Toplam enerji', 'Entropi', 'Sıcaklık', 'İç enerji', 'B', 'Very Hard'),
(1, 'en', 'According to the second law of thermodynamics, which of the following quantities is not expected to decrease over time in an isolated system?', 'Total energy', 'Entropy', 'Temperature', 'Internal energy', 'B', 'Very Hard'),
(1, 'es', 'Según la segunda ley de la termodinámica, ¿cuál de las siguientes magnitudes no se espera que disminuya con el tiempo en un sistema aislado?', 'Energía total', 'Entropía', 'Temperatura', 'Energía interna', 'B', 'Very Hard'),

-- History (Tarih)
(2, 'tr', 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?', '23 Nisan 1920', '29 Ekim 1923', '19 Mayıs 1919', '30 Ağustos 1922', 'B', 'Easy'),
(2, 'en', 'On what date was the Republic of Türkiye proclaimed?', '23 April 1920', '29 October 1923', '19 May 1919', '30 August 1922', 'B', 'Easy'),
(2, 'es', '¿En qué fecha fue proclamada la República de Türkiye?', '23 de abril de 1920', '29 de octubre de 1923', '19 de mayo de 1919', '30 de agosto de 1922', 'B', 'Easy'),

(2, 'tr', 'İstanbul hangi Osmanlı padişahı döneminde fethedilmiştir?', 'I. Murad', 'Yıldırım Bayezid', 'II. Mehmed', 'Kanuni Sultan Süleyman', 'C', 'Easy'),
(2, 'en', 'During the reign of which Ottoman sultan was Istanbul conquered?', 'Murad I', 'Bayezid I', 'Mehmed II', 'Suleiman the Magnificent', 'C', 'Easy'),
(2, 'es', '¿Durante el reinado de qué sultán otomano fue conquistada Estambul?', 'Murad I', 'Bayaceto I', 'Mehmed II', 'Solimán el Magnífico', 'C', 'Easy'),

(2, 'tr', 'Türkiye Büyük Millet Meclisi hangi tarihte açılmıştır?', '19 Mayıs 1919', '23 Nisan 1920', '29 Ekim 1923', '30 Ağustos 1922', 'B', 'Easy'),
(2, 'en', 'On what date was the Grand National Assembly of Türkiye opened?', '19 May 1919', '23 April 1920', '29 October 1923', '30 August 1922', 'B', 'Easy'),
(2, 'es', '¿En qué fecha se inauguró la Gran Asamblea Nacional de Türkiye?', '19 de mayo de 1919', '23 de abril de 1920', '29 de octubre de 1923', '30 de agosto de 1922', 'B', 'Easy'),

(2, 'tr', 'Mustafa Kemal Atatürk''ün Samsun''a çıktığı tarih hangisidir?', '23 Nisan 1920', '19 Mayıs 1919', '10 Kasım 1938', '29 Ekim 1923', 'B', 'Easy'),
(2, 'en', 'What is the date when Mustafa Kemal Atatürk arrived in Samsun?', '23 April 1920', '19 May 1919', '10 November 1938', '29 October 1923', 'B', 'Easy'),
(2, 'es', '¿Cuál es la fecha en que Mustafa Kemal Atatürk llegó a Samsun?', '23 de abril de 1920', '19 de mayo de 1919', '10 de noviembre de 1938', '29 de octubre de 1923', 'B', 'Easy'),

(2, 'tr', 'Osmanlı Devleti''nin kurucusu olarak kabul edilen kişi kimdir?', 'Osman Gazi', 'Orhan Gazi', 'I. Murad', 'Yıldırım Bayezid', 'A', 'Easy'),
(2, 'en', 'Who is considered the founder of the Ottoman Empire?', 'Osman Gazi', 'Orhan Gazi', 'Murad I', 'Bayezid I', 'A', 'Easy'),
(2, 'es', '¿Quién es considerado el fundador del Imperio otomano?', 'Osman Gazi', 'Orhan Gazi', 'Murad I', 'Bayaceto I', 'A', 'Easy'),

(2, 'tr', 'Malazgirt Savaşı hangi yıl gerçekleşmiştir?', '1071', '1176', '1453', '1517', 'A', 'Easy'),
(2, 'en', 'In which year did the Battle of Manzikert take place?', '1071', '1176', '1453', '1517', 'A', 'Easy'),
(2, 'es', '¿En qué año tuvo lugar la batalla de Manzikert?', '1071', '1176', '1453', '1517', 'A', 'Easy'),

(2, 'tr', 'Fransız İhtilali hangi yıl başlamıştır?', '1688', '1776', '1789', '1815', 'C', 'Easy'),
(2, 'en', 'In which year did the French Revolution begin?', '1688', '1776', '1789', '1815', 'C', 'Easy'),
(2, 'es', '¿En qué año comenzó la Revolución Francesa?', '1688', '1776', '1789', '1815', 'C', 'Easy'),

(2, 'tr', 'Kurtuluş Savaşı''nda Yunan ordusuna karşı kazanılan kesin zaferi simgeleyen Büyük Taarruz hangi yıl gerçekleşmiştir?', '1919', '1920', '1921', '1922', 'D', 'Easy'),
(2, 'en', 'In which year did the Great Offensive, which symbolized the decisive victory against the Greek army in the Turkish War of Independence, take place?', '1919', '1920', '1921', '1922', 'D', 'Easy'),
(2, 'es', '¿En qué año tuvo lugar la Gran Ofensiva, que simbolizó la victoria decisiva contra el ejército griego en la Guerra de Independencia de Turquía?', '1919', '1920', '1921', '1922', 'D', 'Easy'),

(2, 'tr', 'Osmanlı Devleti''nde Tanzimat Fermanı hangi padişah döneminde ilan edilmiştir?', 'II. Mahmud', 'Abdülmecid', 'Abdülaziz', 'II. Abdülhamid', 'B', 'Easy'),
(2, 'en', 'During the reign of which sultan was the Tanzimat Edict proclaimed in the Ottoman Empire?', 'Mahmud II', 'Abdülmecid', 'Abdülaziz', 'Abdülhamid II', 'B', 'Easy'),
(2, 'es', '¿Durante el reinado de qué sultán fue proclamado el Edicto de Tanzimat en el Imperio otomano?', 'Mahmud II', 'Abdülmecid', 'Abdülaziz', 'Abdülhamid II', 'B', 'Easy'),

(2, 'tr', 'Birinci Dünya Savaşı hangi yıl başlamıştır?', '1912', '1914', '1916', '1918', 'B', 'Easy'),
(2, 'en', 'In which year did the First World War begin?', '1912', '1914', '1916', '1918', 'B', 'Easy'),
(2, 'es', '¿En qué año comenzó la Primera Guerra Mundial?', '1912', '1914', '1916', '1918', 'B', 'Easy'),

(2, 'tr', 'Lozan Barış Antlaşması hangi yıl imzalanmıştır?', '1920', '1921', '1923', '1925', 'C', 'Medium'),
(2, 'en', 'In which year was the Treaty of Lausanne signed?', '1920', '1921', '1923', '1925', 'C', 'Medium'),
(2, 'es', '¿En qué año se firmó el Tratado de Lausana?', '1920', '1921', '1923', '1925', 'C', 'Medium'),

(2, 'tr', 'Osmanlı Devleti''nde Yeniçeri Ocağı hangi padişah döneminde kaldırılmıştır?', 'III. Selim', 'II. Mahmud', 'Abdülmecid', 'II. Abdülhamid', 'B', 'Medium'),
(2, 'en', 'During the reign of which sultan was the Janissary Corps abolished in the Ottoman Empire?', 'Selim III', 'Mahmud II', 'Abdülmecid', 'Abdülhamid II', 'B', 'Medium'),
(2, 'es', '¿Durante el reinado de qué sultán fue abolido el cuerpo de jenízaros en el Imperio otomano?', 'Selim III', 'Mahmud II', 'Abdülmecid', 'Abdülhamid II', 'B', 'Medium'),

(2, 'tr', 'Kadeş Antlaşması esas olarak hangi iki devlet arasında imzalanmıştır?', 'Roma ve Kartaca', 'Mısır ve Hititler', 'Persler ve Yunanlar', 'Bizans ve Sasani İmparatorluğu', 'B', 'Medium'),
(2, 'en', 'The Treaty of Kadesh was primarily signed between which two states?', 'Rome and Carthage', 'Egypt and the Hittites', 'Persians and Greeks', 'Byzantine and Sasanian Empires', 'B', 'Medium'),
(2, 'es', '¿Entre qué dos estados se firmó principalmente el Tratado de Kadesh?', 'Roma y Cartago', 'Egipto y los hititas', 'Persas y griegos', 'Imperios bizantino y sasánida', 'B', 'Medium'),

(2, 'tr', 'Berlin Duvarı hangi yıl yıkılmıştır?', '1975', '1981', '1989', '1991', 'C', 'Medium'),
(2, 'en', 'In which year was the Berlin Wall demolished?', '1975', '1981', '1989', '1991', 'C', 'Medium'),
(2, 'es', '¿En qué año fue derribado el Muro de Berlín?', '1975', '1981', '1989', '1991', 'C', 'Medium'),

(2, 'tr', 'Türkiye Cumhuriyeti''nde kadınlara milletvekili seçme ve seçilme hakkı hangi yıl verilmiştir?', '1926', '1930', '1934', '1938', 'C', 'Medium'),
(2, 'en', 'In which year were women in the Republic of Türkiye granted the right to vote and stand for election as members of parliament?', '1926', '1930', '1934', '1938', 'C', 'Medium'),
(2, 'es', '¿En qué año se concedió a las mujeres de la República de Türkiye el derecho a votar y a ser elegidas como diputadas?', '1926', '1930', '1934', '1938', 'C', 'Medium'),

(2, 'tr', 'Osmanlı Devleti''nde ilk Osmanlı matbaasını kuran kişilerden biri olan İbrahim Müteferrika''nın matbaası hangi padişah döneminde faaliyete başlamıştır?', 'III. Ahmed', 'I. Mahmud', 'III. Mustafa', 'I. Abdülhamid', 'A', 'Hard'),
(2, 'en', 'During the reign of which sultan did the printing press of İbrahim Müteferrika, one of the people who established the first Ottoman printing press, begin operating?', 'Ahmed III', 'Mahmud I', 'Mustafa III', 'Abdülhamid I', 'A', 'Hard'),
(2, 'es', '¿Durante el reinado de qué sultán comenzó a funcionar la imprenta de İbrahim Müteferrika, una de las personas que fundó la primera imprenta otomana?', 'Ahmed III', 'Mahmud I', 'Mustafa III', 'Abdülhamid I', 'A', 'Hard'),

(2, 'tr', 'Westphalia Barışı hangi savaşın sona ermesiyle ilişkilendirilir?', 'Yedi Yıl Savaşı', 'Otuz Yıl Savaşı', 'Yüz Yıl Savaşı', 'İspanya Veraset Savaşı', 'B', 'Hard'),
(2, 'en', 'The Peace of Westphalia is associated with the end of which war?', 'Seven Years'' War', 'Thirty Years'' War', 'Hundred Years'' War', 'War of the Spanish Succession', 'B', 'Hard'),
(2, 'es', '¿Con el final de qué guerra se relaciona la Paz de Westfalia?', 'Guerra de los Siete Años', 'Guerra de los Treinta Años', 'Guerra de los Cien Años', 'Guerra de Sucesión Española', 'B', 'Hard'),

(2, 'tr', 'Bizans İmparatorluğu''nun son imparatoru kimdir?', 'I. Justinianus', 'II. Basileios', 'XI. Konstantinos', 'I. Aleksios', 'C', 'Hard'),
(2, 'en', 'Who was the last emperor of the Byzantine Empire?', 'Justinian I', 'Basil II', 'Constantine XI', 'Alexios I', 'C', 'Hard'),
(2, 'es', '¿Quién fue el último emperador del Imperio bizantino?', 'Justiniano I', 'Basilio II', 'Constantino XI', 'Alejo I', 'C', 'Hard'),

(2, 'tr', 'Osmanlı Devleti''nin Avrupa''daki ilk sürekli elçiliği hangi padişah döneminde açılmıştır?', 'III. Ahmed', 'III. Selim', 'II. Mahmud', 'Abdülmecid', 'B', 'Very Hard'),
(2, 'en', 'During the reign of which sultan was the Ottoman Empire''s first permanent embassy in Europe opened?', 'Ahmed III', 'Selim III', 'Mahmud II', 'Abdülmecid', 'B', 'Very Hard'),
(2, 'es', '¿Durante el reinado de qué sultán se abrió la primera embajada permanente del Imperio otomano en Europa?', 'Ahmed III', 'Selim III', 'Mahmud II', 'Abdülmecid', 'B', 'Very Hard'),

(2, 'tr', 'Napolyon Bonapart''ın Mısır Seferi''nin ardından Osmanlı Devleti ile Fransa arasında imzalanan ve Osmanlı''nın Fransa''ya karşı Rusya ve İngiltere ile ittifak yapmasına yol açan antlaşma hangisidir?', 'Küçük Kaynarca Antlaşması', 'Yaş Antlaşması', 'Paris Antlaşması', 'Ziştovi Antlaşması', 'C', 'Very Hard'),
(2, 'en', 'Which treaty was signed between the Ottoman Empire and France after Napoleon Bonaparte''s Egyptian campaign and led the Ottoman Empire to form an alliance with Russia and England against France?', 'Treaty of Küçük Kaynarca', 'Treaty of Iași', 'Treaty of Paris', 'Treaty of Sistova', 'C', 'Very Hard'),
(2, 'es', '¿Qué tratado se firmó entre el Imperio otomano y Francia después de la campaña egipcia de Napoleón Bonaparte y llevó al Imperio otomano a aliarse con Rusia e Inglaterra contra Francia?', 'Tratado de Küçük Kaynarca', 'Tratado de Iași', 'Tratado de París', 'Tratado de Sistova', 'C', 'Very Hard'),

-- Geography (Coğrafya)
(3, 'tr', 'Dünya''nın en büyük kıtası hangisidir?', 'Afrika', 'Asya', 'Avrupa', 'Kuzey Amerika', 'B', 'Easy'),
(3, 'en', 'What is the largest continent in the world?', 'Africa', 'Asia', 'Europe', 'North America', 'B', 'Easy'),
(3, 'es', '¿Cuál es el continente más grande del mundo?', 'África', 'Asia', 'Europa', 'América del Norte', 'B', 'Easy'),

(3, 'tr', 'Türkiye''nin başkenti neresidir?', 'İstanbul', 'İzmir', 'Ankara', 'Bursa', 'C', 'Easy'),
(3, 'en', 'What is the capital of Türkiye?', 'Istanbul', 'Izmir', 'Ankara', 'Bursa', 'C', 'Easy'),
(3, 'es', '¿Cuál es la capital de Türkiye?', 'Estambul', 'Esmirna', 'Ankara', 'Bursa', 'C', 'Easy'),

(3, 'tr', 'Dünya''nın en büyük okyanusu hangisidir?', 'Atlas Okyanusu', 'Hint Okyanusu', 'Arktik Okyanusu', 'Pasifik Okyanusu', 'D', 'Easy'),
(3, 'en', 'What is the largest ocean in the world?', 'Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean', 'D', 'Easy'),
(3, 'es', '¿Cuál es el océano más grande del mundo?', 'Océano Atlántico', 'Océano Índico', 'Océano Ártico', 'Océano Pacífico', 'D', 'Easy'),

(3, 'tr', 'Nil Nehri hangi kıtada bulunur?', 'Asya', 'Afrika', 'Avrupa', 'Güney Amerika', 'B', 'Easy'),
(3, 'en', 'On which continent is the Nile River located?', 'Asia', 'Africa', 'Europe', 'South America', 'B', 'Easy'),
(3, 'es', '¿En qué continente se encuentra el río Nilo?', 'Asia', 'África', 'Europa', 'América del Sur', 'B', 'Easy'),

(3, 'tr', 'Türkiye''nin en uzun kıyı şeridine sahip denizi hangisidir?', 'Karadeniz', 'Marmara Denizi', 'Akdeniz', 'Ege Denizi', 'C', 'Easy'),
(3, 'en', 'Which sea has the longest coastline in Türkiye?', 'Black Sea', 'Sea of Marmara', 'Mediterranean Sea', 'Aegean Sea', 'C', 'Easy'),
(3, 'es', '¿Qué mar tiene la costa más larga de Türkiye?', 'Mar Negro', 'Mar de Mármara', 'Mar Mediterráneo', 'Mar Egeo', 'C', 'Easy'),

(3, 'tr', 'Dünya''nın en yüksek dağı hangisidir?', 'K2', 'Everest', 'Kilimanjaro', 'Elbruz', 'B', 'Easy'),
(3, 'en', 'What is the highest mountain in the world?', 'K2', 'Everest', 'Kilimanjaro', 'Elbrus', 'B', 'Easy'),
(3, 'es', '¿Cuál es la montaña más alta del mundo?', 'K2', 'Everest', 'Kilimanjaro', 'Elbrús', 'B', 'Easy'),

(3, 'tr', 'Sahra Çölü hangi kıtada yer alır?', 'Asya', 'Afrika', 'Avustralya', 'Güney Amerika', 'B', 'Easy'),
(3, 'en', 'On which continent is the Sahara Desert located?', 'Asia', 'Africa', 'Australia', 'South America', 'B', 'Easy'),
(3, 'es', '¿En qué continente se encuentra el desierto del Sahara?', 'Asia', 'África', 'Australia', 'América del Sur', 'B', 'Easy'),

(3, 'tr', 'Ekvator, Dünya''yı hangi iki yarım küreye ayırır?', 'Doğu ve Batı', 'Kuzey ve Güney', 'Kara ve Deniz', 'Tropikal ve Kutupsal', 'B', 'Easy'),
(3, 'en', 'Which two hemispheres does the Equator divide the Earth into?', 'Eastern and Western', 'Northern and Southern', 'Land and Sea', 'Tropical and Polar', 'B', 'Easy'),
(3, 'es', '¿En qué dos hemisferios divide el ecuador a la Tierra?', 'Este y Oeste', 'Norte y Sur', 'Tierra y Mar', 'Tropical y Polar', 'B', 'Easy'),

(3, 'tr', 'İtalya''nın başkenti aşağıdakilerden hangisidir?', 'Milano', 'Venedik', 'Roma', 'Napoli', 'C', 'Easy'),
(3, 'en', 'Which of the following is the capital of Italy?', 'Milan', 'Venice', 'Rome', 'Naples', 'C', 'Easy'),
(3, 'es', '¿Cuál de las siguientes es la capital de Italia?', 'Milán', 'Venecia', 'Roma', 'Nápoles', 'C', 'Easy'),

(3, 'tr', 'Türkiye''nin yüz ölçümü bakımından en büyük gölü hangisidir?', 'Tuz Gölü', 'Beyşehir Gölü', 'Van Gölü', 'İznik Gölü', 'C', 'Easy'),
(3, 'en', 'Which is the largest lake in Türkiye by surface area?', 'Lake Tuz', 'Lake Beyşehir', 'Lake Van', 'Lake İznik', 'C', 'Easy'),
(3, 'es', '¿Cuál es el lago más grande de Türkiye por superficie?', 'Lago Tuz', 'Lago Beyşehir', 'Lago Van', 'Lago İznik', 'C', 'Easy'),

(3, 'tr', 'Türkiye''nin en yüksek dağı hangisidir?', 'Erciyes Dağı', 'Süphan Dağı', 'Ağrı Dağı', 'Kaçkar Dağları', 'C', 'Medium'),
(3, 'en', 'What is the highest mountain in Türkiye?', 'Mount Erciyes', 'Mount Süphan', 'Mount Ararat', 'Kaçkar Mountains', 'C', 'Medium'),
(3, 'es', '¿Cuál es la montaña más alta de Türkiye?', 'Monte Erciyes', 'Monte Süphan', 'Monte Ararat', 'Montes Kaçkar', 'C', 'Medium'),

(3, 'tr', 'Akdeniz ile Atlas Okyanusu''nu birbirine bağlayan boğaz hangisidir?', 'Hürmüz Boğazı', 'Bering Boğazı', 'Cebelitarık Boğazı', 'Malakka Boğazı', 'C', 'Medium'),
(3, 'en', 'Which strait connects the Mediterranean Sea with the Atlantic Ocean?', 'Strait of Hormuz', 'Bering Strait', 'Strait of Gibraltar', 'Strait of Malacca', 'C', 'Medium'),
(3, 'es', '¿Qué estrecho conecta el mar Mediterráneo con el océano Atlántico?', 'Estrecho de Ormuz', 'Estrecho de Bering', 'Estrecho de Gibraltar', 'Estrecho de Malaca', 'C', 'Medium'),

(3, 'tr', 'Amazon Nehri hangi kıtada yer alır?', 'Afrika', 'Asya', 'Güney Amerika', 'Kuzey Amerika', 'C', 'Medium'),
(3, 'en', 'On which continent is the Amazon River located?', 'Africa', 'Asia', 'South America', 'North America', 'C', 'Medium'),
(3, 'es', '¿En qué continente se encuentra el río Amazonas?', 'África', 'Asia', 'América del Sur', 'América del Norte', 'C', 'Medium'),

(3, 'tr', 'Türkiye''de yüz ölçümü bakımından en küçük coğrafi bölge hangisidir?', 'Marmara Bölgesi', 'Ege Bölgesi', 'Güneydoğu Anadolu Bölgesi', 'Karadeniz Bölgesi', 'C', 'Medium'),
(3, 'en', 'Which is the smallest geographical region in Türkiye by surface area?', 'Marmara Region', 'Aegean Region', 'Southeastern Anatolia Region', 'Black Sea Region', 'C', 'Medium'),
(3, 'es', '¿Cuál es la región geográfica más pequeña de Türkiye por superficie?', 'Región de Mármara', 'Región del Egeo', 'Región de Anatolia Sudoriental', 'Región del Mar Negro', 'C', 'Medium'),

(3, 'tr', 'Dünya''nın en derin gölü olarak kabul edilen Baykal Gölü hangi ülkededir?', 'Kazakistan', 'Rusya', 'Moğolistan', 'Çin', 'B', 'Medium'),
(3, 'en', 'In which country is Lake Baikal, considered the deepest lake in the world, located?', 'Kazakhstan', 'Russia', 'Mongolia', 'China', 'B', 'Medium'),
(3, 'es', '¿En qué país se encuentra el lago Baikal, considerado el lago más profundo del mundo?', 'Kazajistán', 'Rusia', 'Mongolia', 'China', 'B', 'Medium'),

(3, 'tr', 'Türkiye''de iki kıta arasında yer alan ve İstanbul Boğazı ile Çanakkale Boğazı''nı bünyesinde barındıran deniz hangisidir?', 'Karadeniz', 'Ege Denizi', 'Marmara Denizi', 'Akdeniz', 'C', 'Hard'),
(3, 'en', 'Which sea in Türkiye lies between two continents and contains the Bosporus and Dardanelles straits?', 'Black Sea', 'Aegean Sea', 'Sea of Marmara', 'Mediterranean Sea', 'C', 'Hard'),
(3, 'es', '¿Qué mar de Türkiye se encuentra entre dos continentes y contiene los estrechos del Bósforo y de los Dardanelos?', 'Mar Negro', 'Mar Egeo', 'Mar de Mármara', 'Mar Mediterráneo', 'C', 'Hard'),

(3, 'tr', 'Dünya''nın en büyük sıcak çölü olan Sahra Çölü yaklaşık olarak hangi kıtanın kuzey bölümünün büyük kısmını kaplar?', 'Afrika', 'Asya', 'Avustralya', 'Güney Amerika', 'A', 'Hard'),
(3, 'en', 'The Sahara Desert, the world''s largest hot desert, covers approximately most of the northern part of which continent?', 'Africa', 'Asia', 'Australia', 'South America', 'A', 'Hard'),
(3, 'es', 'El desierto del Sahara, el desierto cálido más grande del mundo, cubre aproximadamente gran parte de la parte norte de ¿qué continente?', 'África', 'Asia', 'Australia', 'América del Sur', 'A', 'Hard'),

(3, 'tr', 'And Dağları hangi iki coğrafi uç arasında uzanan Güney Amerika''nın batı kıyısı boyunca yer alır?', 'Karayip Denizi ile Atlas Okyanusu', 'Panama''dan Tierra del Fuego''ya', 'Amazon Havzası ile Brezilya Platosu', 'Ekvador''dan Galapagos Adaları''na', 'B', 'Hard'),
(3, 'en', 'The Andes Mountains lie along the western coast of South America, extending between which two geographic endpoints?', 'Caribbean Sea and Atlantic Ocean', 'From Panama to Tierra del Fuego', 'Amazon Basin and Brazilian Plateau', 'From Ecuador to the Galápagos Islands', 'B', 'Hard'),
(3, 'es', '¿Entre qué dos extremos geográficos se extienden los Andes a lo largo de la costa occidental de América del Sur?', 'Mar Caribe y océano Atlántico', 'Desde Panamá hasta Tierra del Fuego', 'Cuenca del Amazonas y meseta brasileña', 'Desde Ecuador hasta las islas Galápagos', 'B', 'Hard'),

(3, 'tr', 'Dünya üzerindeki en uzun kara sınırını hangi iki ülke paylaşır?', 'Rusya ve Kazakistan', 'ABD ve Kanada', 'Çin ve Moğolistan', 'Arjantin ve Şili', 'B', 'Very Hard'),
(3, 'en', 'Which two countries share the longest land border in the world?', 'Russia and Kazakhstan', 'United States and Canada', 'China and Mongolia', 'Argentina and Chile', 'B', 'Very Hard'),
(3, 'es', '¿Qué dos países comparten la frontera terrestre más larga del mundo?', 'Rusia y Kazajistán', 'Estados Unidos y Canadá', 'China y Mongolia', 'Argentina y Chile', 'B', 'Very Hard'),

(3, 'tr', 'Hangi ülke hem Atlas Okyanusu''na hem de Akdeniz''e kıyısı bulunan ve Cebelitarık Boğazı''nın Avrupa tarafında yer alan ülkedir?', 'İspanya', 'Portekiz', 'İtalya', 'Fransa', 'A', 'Very Hard'),
(3, 'en', 'Which country has coastlines on both the Atlantic Ocean and the Mediterranean Sea and is located on the European side of the Strait of Gibraltar?', 'Spain', 'Portugal', 'Italy', 'France', 'A', 'Very Hard'),
(3, 'es', '¿Qué país tiene costas tanto en el océano Atlántico como en el mar Mediterráneo y está situado en el lado europeo del estrecho de Gibraltar?', 'España', 'Portugal', 'Italia', 'Francia', 'A', 'Very Hard'),
-- Sports (Spor)

(4, 'tr', 'Futbolda bir takım sahada kaç oyuncuyla oynar?', '9', '10', '11', '12', 'C', 'Easy'),
(4, 'en', 'How many players does a football team have on the field?', '9', '10', '11', '12', 'C', 'Easy'),
(4, 'es', '¿Con cuántos jugadores juega un equipo de fútbol en el campo?', '9', '10', '11', '12', 'C', 'Easy'),

(4, 'tr', 'Olimpiyat Oyunları''nda beş halkalı sembol kaç halkadan oluşur?', '4', '5', '6', '7', 'B', 'Easy'),
(4, 'en', 'How many rings make up the five-ring symbol of the Olympic Games?', '4', '5', '6', '7', 'B', 'Easy'),
(4, 'es', '¿Cuántos anillos forman el símbolo de cinco anillos de los Juegos Olímpicos?', '4', '5', '6', '7', 'B', 'Easy'),

(4, 'tr', 'Basketbolda serbest atış başarılı olduğunda kaç sayı kazandırır?', '1', '2', '3', '4', 'A', 'Easy'),
(4, 'en', 'How many points is a successful free throw worth in basketball?', '1', '2', '3', '4', 'A', 'Easy'),
(4, 'es', '¿Cuántos puntos vale un tiro libre convertido en baloncesto?', '1', '2', '3', '4', 'A', 'Easy'),

(4, 'tr', 'Teniste sıfır puanı ifade etmek için hangi terim kullanılır?', 'Love', 'Ace', 'Deuce', 'Fault', 'A', 'Easy'),
(4, 'en', 'Which term is used to indicate zero points in tennis?', 'Love', 'Ace', 'Deuce', 'Fault', 'A', 'Easy'),
(4, 'es', '¿Qué término se utiliza para indicar cero puntos en tenis?', 'Love', 'Ace', 'Deuce', 'Fault', 'A', 'Easy'),

(4, 'tr', 'Voleybolda bir takım sahada aynı anda kaç oyuncuyla yer alır?', '5', '6', '7', '8', 'B', 'Easy'),
(4, 'en', 'How many players does a volleyball team have on the court at the same time?', '5', '6', '7', '8', 'B', 'Easy'),
(4, 'es', '¿Con cuántos jugadores está un equipo de voleibol en la cancha al mismo tiempo?', '5', '6', '7', '8', 'B', 'Easy'),

(4, 'tr', 'Futbolda topun tamamının kale çizgisini geçmesi durumunda hangi sonuç oluşur?', 'Korner', 'Taç', 'Gol', 'Ofsayt', 'C', 'Easy'),
(4, 'en', 'What is the result when the entire ball crosses the goal line in football?', 'Corner kick', 'Throw-in', 'Goal', 'Offside', 'C', 'Easy'),
(4, 'es', '¿Qué ocurre cuando el balón cruza completamente la línea de gol en fútbol?', 'Córner', 'Saque de banda', 'Gol', 'Fuera de juego', 'C', 'Easy'),

(4, 'tr', 'Formula 1 yarışlarında damalı bayrak neyi ifade eder?', 'Yarışın başladığını', 'Güvenlik aracının çıktığını', 'Yarışın sona erdiğini', 'Pit yolunun kapandığını', 'C', 'Easy'),
(4, 'en', 'What does the checkered flag indicate in Formula 1 races?', 'That the race has started', 'That the safety car has been deployed', 'That the race has ended', 'That the pit lane is closed', 'C', 'Easy'),
(4, 'es', '¿Qué indica la bandera a cuadros en las carreras de Fórmula 1?', 'Que la carrera ha comenzado', 'Que ha salido el coche de seguridad', 'Que la carrera ha terminado', 'Que el pit lane está cerrado', 'C', 'Easy'),

(4, 'tr', 'Boks müsabakasında sporcuların kullandığı temel ekipman hangisidir?', 'Raket', 'Eldiven', 'Sopa', 'Kask', 'B', 'Easy'),
(4, 'en', 'What is the basic equipment used by athletes in a boxing match?', 'Racket', 'Gloves', 'Stick', 'Helmet', 'B', 'Easy'),
(4, 'es', '¿Cuál es el equipamiento básico que utilizan los deportistas en un combate de boxeo?', 'Raqueta', 'Guantes', 'Palo', 'Casco', 'B', 'Easy'),

(4, 'tr', 'Maraton yarışının resmi uzunluğu yaklaşık kaç kilometredir?', '21,1 km', '30 km', '42,195 km', '50 km', 'C', 'Easy'),
(4, 'en', 'What is the official distance of a marathon, approximately?', '21.1 km', '30 km', '42.195 km', '50 km', 'C', 'Easy'),
(4, 'es', '¿Cuál es aproximadamente la distancia oficial de una maratón?', '21,1 km', '30 km', '42,195 km', '50 km', 'C', 'Easy'),

(4, 'tr', 'Satrançta oyunun başında her oyuncunun kaç taşı bulunur?', '12', '14', '16', '18', 'C', 'Easy'),
(4, 'en', 'How many pieces does each player have at the beginning of a chess game?', '12', '14', '16', '18', 'C', 'Easy'),
(4, 'es', '¿Cuántas piezas tiene cada jugador al comienzo de una partida de ajedrez?', '12', '14', '16', '18', 'C', 'Easy'),

(4, 'tr', 'Futbolda bir oyuncunun aynı maçta üç gol atmasına ne ad verilir?', 'Hat-trick', 'Duble', 'Asist', 'Clean sheet', 'A', 'Medium'),
(4, 'en', 'What is it called when a player scores three goals in the same football match?', 'Hat-trick', 'Brace', 'Assist', 'Clean sheet', 'A', 'Medium'),
(4, 'es', '¿Cómo se llama cuando un jugador marca tres goles en el mismo partido de fútbol?', 'Hat-trick', 'Doblete', 'Asistencia', 'Portería a cero', 'A', 'Medium'),

(4, 'tr', 'Basketbolda üç sayı çizgisinin gerisinden yapılan başarılı bir atış kaç sayı değerindedir?', '1', '2', '3', '4', 'C', 'Medium'),
(4, 'en', 'How many points is a successful shot from behind the three-point line worth in basketball?', '1', '2', '3', '4', 'C', 'Medium'),
(4, 'es', '¿Cuántos puntos vale un lanzamiento convertido desde detrás de la línea de tres puntos en baloncesto?', '1', '2', '3', '4', 'C', 'Medium'),

(4, 'tr', 'Olimpiyat Oyunları''nda yüzme yarışları hangi spor dalının bir parçasıdır?', 'Su topu', 'Atletizm', 'Yüzme', 'Kürek', 'C', 'Medium'),
(4, 'en', 'Swimming competitions at the Olympic Games are part of which sport?', 'Water polo', 'Athletics', 'Swimming', 'Rowing', 'C', 'Medium'),
(4, 'es', '¿Las competiciones de natación de los Juegos Olímpicos forman parte de qué deporte?', 'Waterpolo', 'Atletismo', 'Natación', 'Remo', 'C', 'Medium'),

(4, 'tr', 'Teniste bir sette 6-6 eşitlik oluştuğunda çoğu standart sette oynanan karar oyununun adı nedir?', 'Tie-break', 'Golden set', 'Sudden death', 'Match point', 'A', 'Medium'),
(4, 'en', 'What is the name of the deciding game played in most standard tennis sets when the score reaches 6-6?', 'Tie-break', 'Golden set', 'Sudden death', 'Match point', 'A', 'Medium'),
(4, 'es', '¿Cómo se llama el juego decisivo que se disputa en la mayoría de los sets estándar de tenis cuando el marcador llega a 6-6?', 'Tie-break', 'Golden set', 'Sudden death', 'Match point', 'A', 'Medium'),

(4, 'tr', 'Futbolda bir oyuncunun rakibine yaptığı ciddi kural ihlali sonucunda doğrudan hangi kartla oyundan ihraç edilebilir?', 'Beyaz kart', 'Sarı kart', 'Turuncu kart', 'Kırmızı kart', 'D', 'Medium'),
(4, 'en', 'Which card can a football player receive for a serious foul against an opponent resulting in immediate dismissal?', 'White card', 'Yellow card', 'Orange card', 'Red card', 'D', 'Medium'),
(4, 'es', '¿Con qué tarjeta puede ser expulsado directamente un jugador de fútbol por una infracción grave contra un adversario?', 'Tarjeta blanca', 'Tarjeta amarilla', 'Tarjeta naranja', 'Tarjeta roja', 'D', 'Medium'),

(4, 'tr', 'Modern Olimpiyat Oyunları''nda erkekler 100 metre dünya rekorunu 9,58 saniyelik dereceyle kıran atlet kimdir?', 'Carl Lewis', 'Usain Bolt', 'Michael Johnson', 'Mo Farah', 'B', 'Hard'),
(4, 'en', 'Who is the athlete who set the men''s 100-meter world record at 9.58 seconds in the modern era of the Olympic Games?', 'Carl Lewis', 'Usain Bolt', 'Michael Johnson', 'Mo Farah', 'B', 'Hard'),
(4, 'es', '¿Quién es el atleta que estableció el récord mundial masculino de 100 metros con un tiempo de 9,58 segundos en la era moderna de los Juegos Olímpicos?', 'Carl Lewis', 'Usain Bolt', 'Michael Johnson', 'Mo Farah', 'B', 'Hard'),

(4, 'tr', 'Basketbolda NBA''de bir takımın normal oyun süresi, dört çeyreğin her biri 12 dakika olduğuna göre toplam kaç dakikadır?', '36', '40', '48', '60', 'C', 'Hard'),
(4, 'en', 'In the NBA, how many total minutes is a team''s regulation playing time if each of the four quarters is 12 minutes?', '36', '40', '48', '60', 'C', 'Hard'),
(4, 'es', 'En la NBA, ¿cuántos minutos dura en total el tiempo reglamentario de un equipo si cada uno de los cuatro cuartos dura 12 minutos?', '36', '40', '48', '60', 'C', 'Hard'),

(4, 'tr', 'Formula 1''de bir yarış hafta sonunda sıralama turlarının temel amacı nedir?', 'En hızlı turu atan sürücünün yarışa ilk sıradan başlamasını belirlemek', 'Yarışın toplam tur sayısını belirlemek', 'Pit stop sayısını zorunlu olarak belirlemek', 'Yarışın kazananını yarıştan önce belirlemek', 'A', 'Hard'),
(4, 'en', 'What is the main purpose of qualifying sessions during a Formula 1 race weekend?', 'To determine that the driver with the fastest lap starts the race from first place', 'To determine the total number of laps in the race', 'To determine the number of mandatory pit stops', 'To determine the winner of the race before it begins', 'A', 'Hard'),
(4, 'es', '¿Cuál es el objetivo principal de las sesiones de clasificación durante un fin de semana de carrera de Fórmula 1?', 'Determinar que el piloto con la vuelta más rápida comience la carrera desde la primera posición', 'Determinar el número total de vueltas de la carrera', 'Determinar obligatoriamente el número de paradas en boxes', 'Determinar al ganador de la carrera antes de que comience', 'A', 'Hard'),

(4, 'tr', 'Satrançta yalnızca şah ve kale ile rakip şahı mat etmek için kullanılan temel teknik aşağıdakilerden hangisidir?', 'Çatal', 'Merdiven matı', 'Şiş', 'Çifte saldırı', 'B', 'Very Hard'),
(4, 'en', 'Which of the following is the basic technique used to checkmate the opponent''s king with only a king and a rook in chess?', 'Fork', 'Ladder mate', 'Skewer', 'Double attack', 'B', 'Very Hard'),
(4, 'es', '¿Cuál de las siguientes es la técnica básica utilizada para dar jaque mate al rey rival con solo un rey y una torre en ajedrez?', 'Tenedor', 'Mate de escalera', 'Clavada', 'Ataque doble', 'B', 'Very Hard'),

(4, 'tr', 'Atletizmde dekatlon yarışmasında sporcular toplam kaç farklı branşta mücadele eder?', '8', '9', '10', '12', 'C', 'Very Hard'),
(4, 'en', 'In athletics, how many different events do athletes compete in during the decathlon?', '8', '9', '10', '12', 'C', 'Very Hard'),
(4, 'es', 'En atletismo, ¿en cuántas disciplinas diferentes compiten los atletas en el decatlón?', '8', '9', '10', '12', 'C', 'Very Hard'),
-- Art (Sanat)
(5, 'tr', 'Leonardo da Vinci''nin en ünlü tablolarından biri aşağıdakilerden hangisidir?', 'Yıldızlı Gece', 'Mona Lisa', 'Çığlık', 'İnci Küpeli Kız', 'B', 'Easy'),
(5, 'en', 'Which of the following is one of Leonardo da Vinci''s most famous paintings?', 'The Starry Night', 'Mona Lisa', 'The Scream', 'Girl with a Pearl Earring', 'B', 'Easy'),
(5, 'es', '¿Cuál de las siguientes es una de las pinturas más famosas de Leonardo da Vinci?', 'La noche estrellada', 'Mona Lisa', 'El grito', 'La joven de la perla', 'B', 'Easy'),

(5, 'tr', 'Vincent van Gogh''un ünlü tablolarından biri aşağıdakilerden hangisidir?', 'Yıldızlı Gece', 'Guernica', 'Son Akşam Yemeği', 'Belleğin Azmi', 'A', 'Easy'),
(5, 'en', 'Which of the following is one of Vincent van Gogh''s famous paintings?', 'The Starry Night', 'Guernica', 'The Last Supper', 'The Persistence of Memory', 'A', 'Easy'),
(5, 'es', '¿Cuál de las siguientes es una de las pinturas famosas de Vincent van Gogh?', 'La noche estrellada', 'Guernica', 'La última cena', 'La persistencia de la memoria', 'A', 'Easy'),

(5, 'tr', 'Pablo Picasso''nun savaşın yıkımını konu alan ünlü eseri hangisidir?', 'Guernica', 'Mona Lisa', 'Venüs''ün Doğuşu', 'Düşünür', 'A', 'Easy'),
(5, 'en', 'Which famous work by Pablo Picasso depicts the devastation of war?', 'Guernica', 'Mona Lisa', 'The Birth of Venus', 'The Thinker', 'A', 'Easy'),
(5, 'es', '¿Cuál es la famosa obra de Pablo Picasso que representa la devastación de la guerra?', 'Guernica', 'Mona Lisa', 'El nacimiento de Venus', 'El pensador', 'A', 'Easy'),

(5, 'tr', 'Michelangelo''nun Sistine Şapeli''nin tavanına yaptığı ünlü eser hangi sanat dalına aittir?', 'Heykel', 'Mimari', 'Fresk', 'Seramik', 'C', 'Easy'),
(5, 'en', 'Which art form does Michelangelo''s famous work on the ceiling of the Sistine Chapel belong to?', 'Sculpture', 'Architecture', 'Fresco', 'Ceramics', 'C', 'Easy'),
(5, 'es', '¿A qué disciplina artística pertenece la famosa obra de Miguel Ángel en el techo de la Capilla Sixtina?', 'Escultura', 'Arquitectura', 'Fresco', 'Cerámica', 'C', 'Easy'),

(5, 'tr', 'Osman Hamdi Bey''in en tanınmış tablolarından biri aşağıdakilerden hangisidir?', 'Kaplumbağa Terbiyecisi', 'Çığlık', 'İnci Küpeli Kız', 'Arşidük Ferdinand''ın Portresi', 'A', 'Easy'),
(5, 'en', 'Which of the following is one of Osman Hamdi Bey''s best-known paintings?', 'The Tortoise Trainer', 'The Scream', 'Girl with a Pearl Earring', 'Portrait of Archduke Ferdinand', 'A', 'Easy'),
(5, 'es', '¿Cuál de las siguientes es una de las pinturas más conocidas de Osman Hamdi Bey?', 'El adiestrador de tortugas', 'El grito', 'La joven de la perla', 'Retrato del archiduque Fernando', 'A', 'Easy'),

(5, 'tr', 'Heykel sanatında üç boyutlu eser oluşturmak için aşağıdaki malzemelerden hangisi yaygın olarak kullanılır?', 'Mermer', 'Kağıt', 'Mürekkep', 'Suluboya', 'A', 'Easy'),
(5, 'en', 'Which of the following materials is commonly used to create three-dimensional works in sculpture?', 'Marble', 'Paper', 'Ink', 'Watercolor', 'A', 'Easy'),
(5, 'es', '¿Cuál de los siguientes materiales se utiliza comúnmente para crear obras tridimensionales en la escultura?', 'Mármol', 'Papel', 'Tinta', 'Acuarela', 'A', 'Easy'),

(5, 'tr', 'Resimde renkleri bir yüzeye uygulamak için kullanılan temel araçlardan biri hangisidir?', 'Fırça', 'Keski', 'Keman yayı', 'Pergel', 'A', 'Easy'),
(5, 'en', 'Which of the following is one of the basic tools used to apply colors to a surface in painting?', 'Brush', 'Chisel', 'Violin bow', 'Compass', 'A', 'Easy'),
(5, 'es', '¿Cuál de los siguientes es uno de los instrumentos básicos utilizados para aplicar colores sobre una superficie en pintura?', 'Pincel', 'Cincel', 'Arco de violín', 'Compás', 'A', 'Easy'),

(5, 'tr', 'Auguste Rodin''in en tanınmış heykellerinden biri hangisidir?', 'Düşünen Adam', 'Davud', 'Diskobol', 'Kanatlı Zafer', 'A', 'Easy'),
(5, 'en', 'Which is one of Auguste Rodin''s most famous sculptures?', 'The Thinker', 'David', 'Discobolus', 'Winged Victory', 'A', 'Easy'),
(5, 'es', '¿Cuál es una de las esculturas más famosas de Auguste Rodin?', 'El pensador', 'David', 'Discóbolo', 'Victoria alada', 'A', 'Easy'),

(5, 'tr', 'Salvador Dalí''nin eriyen saatleriyle tanınan eseri hangisidir?', 'Belleğin Azmi', 'Guernica', 'Öpücük', 'Kırmızı Balon', 'A', 'Easy'),
(5, 'en', 'Which work by Salvador Dalí is known for its melting clocks?', 'The Persistence of Memory', 'Guernica', 'The Kiss', 'The Red Balloon', 'A', 'Easy'),
(5, 'es', '¿Cuál es la obra de Salvador Dalí conocida por sus relojes derretidos?', 'La persistencia de la memoria', 'Guernica', 'El beso', 'El globo rojo', 'A', 'Easy'),

(5, 'tr', 'Edvard Munch''un en tanınmış eserlerinden biri aşağıdakilerden hangisidir?', 'Çığlık', 'Mona Lisa', 'Gece Kuşları', 'Su Zambakları', 'A', 'Easy'),
(5, 'en', 'Which of the following is one of Edvard Munch''s most famous works?', 'The Scream', 'Mona Lisa', 'Nighthawks', 'Water Lilies', 'A', 'Easy'),
(5, 'es', '¿Cuál de las siguientes es una de las obras más famosas de Edvard Munch?', 'El grito', 'Mona Lisa', 'Noctámbulos', 'Nenúfares', 'A', 'Easy'),

(5, 'tr', 'Claude Monet hangi sanat akımının öncülerinden biri olarak kabul edilir?', 'Kübizm', 'Empresyonizm', 'Sürrealizm', 'Ekspresyonizm', 'B', 'Medium'),
(5, 'en', 'Claude Monet is considered one of the pioneers of which art movement?', 'Cubism', 'Impressionism', 'Surrealism', 'Expressionism', 'B', 'Medium'),
(5, 'es', '¿Claude Monet es considerado uno de los pioneros de qué movimiento artístico?', 'Cubismo', 'Impresionismo', 'Surrealismo', 'Expresionismo', 'B', 'Medium'),

(5, 'tr', 'Gustav Klimt''in en tanınmış tablolarından biri aşağıdakilerden hangisidir?', 'Öpücük', 'Çığlık', 'Guernica', 'Kaplumbağa Terbiyecisi', 'A', 'Medium'),
(5, 'en', 'Which of the following is one of Gustav Klimt''s best-known paintings?', 'The Kiss', 'The Scream', 'Guernica', 'The Tortoise Trainer', 'A', 'Medium'),
(5, 'es', '¿Cuál de las siguientes es una de las pinturas más conocidas de Gustav Klimt?', 'El beso', 'El grito', 'Guernica', 'El adiestrador de tortugas', 'A', 'Medium'),

(5, 'tr', 'Piet Mondrian''ın geometrik şekiller ve ana renklerle oluşturduğu eserler hangi sanat anlayışıyla ilişkilidir?', 'Sembolizm', 'De Stijl', 'Barok', 'Rokoko', 'B', 'Medium'),
(5, 'en', 'Piet Mondrian''s works created with geometric shapes and primary colors are associated with which artistic movement?', 'Symbolism', 'De Stijl', 'Baroque', 'Rococo', 'B', 'Medium'),
(5, 'es', '¿Con qué corriente artística se relacionan las obras de Piet Mondrian creadas con formas geométricas y colores primarios?', 'Simbolismo', 'De Stijl', 'Barroco', 'Rococó', 'B', 'Medium'),

(5, 'tr', 'Rönesans sanatının ortaya çıkışında önemli rol oynayan şehir aşağıdakilerden hangisidir?', 'Floransa', 'Londra', 'Moskova', 'Oslo', 'A', 'Medium'),
(5, 'en', 'Which of the following cities played an important role in the emergence of Renaissance art?', 'Florence', 'London', 'Moscow', 'Oslo', 'A', 'Medium'),
(5, 'es', '¿Cuál de las siguientes ciudades desempeñó un papel importante en el surgimiento del arte renacentista?', 'Florencia', 'Londres', 'Moscú', 'Oslo', 'A', 'Medium'),

(5, 'tr', 'Barok sanatında genellikle hangi özellik ön plana çıkar?', 'Hareket, dramatik ışık ve güçlü karşıtlıklar', 'Tamamen geometrik soyutlama', 'Sadece siyah-beyaz kullanım', 'Perspektifin tamamen reddedilmesi', 'A', 'Medium'),
(5, 'en', 'Which characteristic is generally emphasized in Baroque art?', 'Movement, dramatic lighting, and strong contrasts', 'Purely geometric abstraction', 'Use of only black and white', 'Complete rejection of perspective', 'A', 'Medium'),
(5, 'es', '¿Qué característica suele destacar en el arte barroco?', 'Movimiento, iluminación dramática y fuertes contrastes', 'Abstracción completamente geométrica', 'Uso exclusivo del blanco y negro', 'Rechazo total de la perspectiva', 'A', 'Medium'),

(5, 'tr', 'Fransız ressam Georges Seurat''ın küçük renk noktalarını yan yana kullanarak oluşturduğu teknik hangisidir?', 'Kolaj', 'Puantilizm', 'Gravür', 'Fresk', 'B', 'Hard'),
(5, 'en', 'What is the technique used by French painter Georges Seurat that involves placing small dots of color side by side?', 'Collage', 'Pointillism', 'Engraving', 'Fresco', 'B', 'Hard'),
(5, 'es', '¿Cuál es la técnica utilizada por el pintor francés Georges Seurat que consiste en colocar pequeños puntos de color uno al lado del otro?', 'Collage', 'Puntillismo', 'Grabado', 'Fresco', 'B', 'Hard'),

(5, 'tr', 'Leonardo da Vinci''nin ''Son Akşam Yemeği'' adlı eseri hangi şehirdeki Santa Maria delle Grazie manastırının yemekhanesinde bulunmaktadır?', 'Roma', 'Floransa', 'Milano', 'Venedik', 'C', 'Hard'),
(5, 'en', 'In the refectory of the Santa Maria delle Grazie monastery in which city is Leonardo da Vinci''s ''The Last Supper'' located?', 'Rome', 'Florence', 'Milan', 'Venice', 'C', 'Hard'),
(5, 'es', '¿En el refectorio del monasterio de Santa Maria delle Grazie de qué ciudad se encuentra ''La última cena'' de Leonardo da Vinci?', 'Roma', 'Florencia', 'Milán', 'Venecia', 'C', 'Hard'),

(5, 'tr', 'Antik Yunan heykel sanatında ideal insan bedenini temsil eden ve günümüze Roma kopyalarıyla ulaşan ünlü heykellerden biri hangisidir?', 'Diskobol', 'Düşünen Adam', 'Öpücük', 'Kaplumbağa Terbiyecisi', 'A', 'Hard'),
(5, 'en', 'Which of the following is a famous sculpture from Ancient Greek art that represents the ideal human body and has survived through Roman copies?', 'Discobolus', 'The Thinker', 'The Kiss', 'The Tortoise Trainer', 'A', 'Hard'),
(5, 'es', '¿Cuál de las siguientes es una famosa escultura del arte de la Antigua Grecia que representa el cuerpo humano ideal y ha llegado hasta nuestros días mediante copias romanas?', 'Discóbolo', 'El pensador', 'El beso', 'El adiestrador de tortugas', 'A', 'Hard'),

(5, 'tr', 'Caravaggio''nun eserlerinde ışık ve karanlık arasındaki dramatik karşıtlığı belirgin biçimde kullanması hangi teknik veya üslupla ilişkilendirilir?', 'Chiaroscuro', 'Puantilizm', 'Fütürizm', 'Kübizm', 'A', 'Very Hard'),
(5, 'en', 'Caravaggio''s pronounced use of dramatic contrast between light and darkness in his works is associated with which technique or style?', 'Chiaroscuro', 'Pointillism', 'Futurism', 'Cubism', 'A', 'Very Hard'),
(5, 'es', '¿Con qué técnica o estilo se relaciona el uso destacado de Caravaggio del contraste dramático entre la luz y la oscuridad en sus obras?', 'Claroscuro', 'Puntillismo', 'Futurismo', 'Cubismo', 'A', 'Very Hard'),

(5, 'tr', 'Rönesans döneminde sanatçıların gerçekçi mekân ve derinlik oluşturmak için geliştirdiği doğrusal perspektifin sistematik kullanımında adı öne çıkan sanatçı kimdir?', 'Filippo Brunelleschi', 'Claude Monet', 'Edvard Munch', 'Jackson Pollock', 'A', 'Very Hard'),
(5, 'en', 'Which artist is notably associated with the systematic use of linear perspective developed during the Renaissance to create realistic space and depth?', 'Filippo Brunelleschi', 'Claude Monet', 'Edvard Munch', 'Jackson Pollock', 'A', 'Very Hard'),
(5, 'es', '¿Qué artista destaca por el uso sistemático de la perspectiva lineal desarrollada durante el Renacimiento para crear espacio y profundidad realistas?', 'Filippo Brunelleschi', 'Claude Monet', 'Edvard Munch', 'Jackson Pollock', 'A', 'Very Hard'),

-- Technology (Teknoloji)

(6, 'tr', 'Bilgisayarın merkezi işlem biriminin kısaltması aşağıdakilerden hangisidir?', 'RAM', 'CPU', 'GPU', 'SSD', 'B', 'Easy'),
(6, 'en', 'Which of the following is the abbreviation for a computer''s central processing unit?', 'RAM', 'CPU', 'GPU', 'SSD', 'B', 'Easy'),
(6, 'es', '¿Cuál de las siguientes es la abreviatura de la unidad central de procesamiento de una computadora?', 'RAM', 'CPU', 'GPU', 'SSD', 'B', 'Easy'),

(6, 'tr', 'İnternette web sayfalarını görüntülemek için kullanılan yazılıma ne ad verilir?', 'Derleyici', 'Tarayıcı', 'İşletim sistemi', 'Veritabanı', 'B', 'Easy'),
(6, 'en', 'What is the software used to view web pages on the internet called?', 'Compiler', 'Browser', 'Operating system', 'Database', 'B', 'Easy'),
(6, 'es', '¿Cómo se llama el software utilizado para visualizar páginas web en Internet?', 'Compilador', 'Navegador', 'Sistema operativo', 'Base de datos', 'B', 'Easy'),

(6, 'tr', 'Aşağıdakilerden hangisi bir işletim sistemidir?', 'Linux', 'HTML', 'SQL', 'HTTP', 'A', 'Easy'),
(6, 'en', 'Which of the following is an operating system?', 'Linux', 'HTML', 'SQL', 'HTTP', 'A', 'Easy'),
(6, 'es', '¿Cuál de los siguientes es un sistema operativo?', 'Linux', 'HTML', 'SQL', 'HTTP', 'A', 'Easy'),

(6, 'tr', 'Bilgisayarlarda geçici verileri hızlı bir şekilde saklayan bellek türü hangisidir?', 'RAM', 'HDD', 'DVD', 'ROM', 'A', 'Easy'),
(6, 'en', 'Which type of memory stores temporary data quickly in computers?', 'RAM', 'HDD', 'DVD', 'ROM', 'A', 'Easy'),
(6, 'es', '¿Qué tipo de memoria almacena rápidamente datos temporales en las computadoras?', 'RAM', 'HDD', 'DVD', 'ROM', 'A', 'Easy'),

(6, 'tr', 'Bir web sitesinin adresini belirtmek için kullanılan kısaltma aşağıdakilerden hangisidir?', 'URL', 'CPU', 'USB', 'PDF', 'A', 'Easy'),
(6, 'en', 'Which of the following is the abbreviation used to specify the address of a website?', 'URL', 'CPU', 'USB', 'PDF', 'A', 'Easy'),
(6, 'es', '¿Cuál de las siguientes es la abreviatura utilizada para indicar la dirección de un sitio web?', 'URL', 'CPU', 'USB', 'PDF', 'A', 'Easy'),

(6, 'tr', 'USB bağlantı noktalarının temel kullanım amaçlarından biri aşağıdakilerden hangisidir?', 'Cihazlar arasında veri aktarımı', 'Ekran çözünürlüğünü artırmak', 'İşlemciyi soğutmak', 'İşletim sistemini otomatik olarak değiştirmek', 'A', 'Easy'),
(6, 'en', 'Which of the following is one of the main purposes of USB ports?', 'Transferring data between devices', 'Increasing screen resolution', 'Cooling the processor', 'Automatically changing the operating system', 'A', 'Easy'),
(6, 'es', '¿Cuál de las siguientes es una de las principales funciones de los puertos USB?', 'Transferir datos entre dispositivos', 'Aumentar la resolución de la pantalla', 'Enfriar el procesador', 'Cambiar automáticamente el sistema operativo', 'A', 'Easy'),

(6, 'tr', 'Aşağıdakilerden hangisi bir programlama dilidir?', 'Python', 'HTML', 'JPEG', 'HTTP', 'A', 'Easy'),
(6, 'en', 'Which of the following is a programming language?', 'Python', 'HTML', 'JPEG', 'HTTP', 'A', 'Easy'),
(6, 'es', '¿Cuál de los siguientes es un lenguaje de programación?', 'Python', 'HTML', 'JPEG', 'HTTP', 'A', 'Easy'),

(6, 'tr', 'Bir bilgisayarda dosyaları kalıcı olarak saklamak için kullanılan donanımlardan biri hangisidir?', 'RAM', 'SSD', 'CPU', 'GPU', 'B', 'Easy'),
(6, 'en', 'Which of the following is a hardware component used to store files permanently on a computer?', 'RAM', 'SSD', 'CPU', 'GPU', 'B', 'Easy'),
(6, 'es', '¿Cuál de los siguientes es un componente de hardware utilizado para almacenar archivos de forma permanente en una computadora?', 'RAM', 'SSD', 'CPU', 'GPU', 'B', 'Easy'),

(6, 'tr', 'Yapay zekâ kavramı temel olarak aşağıdakilerden hangisini ifade eder?', 'Makinelerin insan benzeri görevleri gerçekleştirebilmesini sağlayan yöntem ve sistemleri', 'Bilgisayarların yalnızca internete bağlanmasını', 'Dosyaların sıkıştırılmasını', 'Elektrik devrelerinin fiziksel olarak küçültülmesini', 'A', 'Easy'),
(6, 'en', 'What does the concept of artificial intelligence basically refer to?', 'Methods and systems that enable machines to perform human-like tasks', 'Computers only connecting to the internet', 'Compressing files', 'Physically shrinking electrical circuits', 'A', 'Easy'),
(6, 'es', '¿A qué se refiere básicamente el concepto de inteligencia artificial?', 'Métodos y sistemas que permiten a las máquinas realizar tareas similares a las humanas', 'Que las computadoras solo se conecten a Internet', 'La compresión de archivos', 'La reducción física de los circuitos eléctricos', 'A', 'Easy'),

(6, 'tr', 'Bir bilgisayar ağında cihazların birbirleriyle iletişim kurmasını sağlayan kurallar bütününe ne ad verilir?', 'Protokol', 'Klasör', 'Sürücü', 'Ekran kartı', 'A', 'Easy'),
(6, 'en', 'What is the set of rules that enables devices to communicate with each other on a computer network called?', 'Protocol', 'Folder', 'Driver', 'Graphics card', 'A', 'Easy'),
(6, 'es', '¿Cómo se denomina el conjunto de reglas que permite a los dispositivos comunicarse entre sí en una red informática?', 'Protocolo', 'Carpeta', 'Controlador', 'Tarjeta gráfica', 'A', 'Easy'),

(6, 'tr', 'DNS''nin temel görevi aşağıdakilerden hangisidir?', 'Alan adlarını IP adresleriyle eşleştirmek', 'Dosyaları şifrelemek', 'İşlemci hızını artırmak', 'Web sayfalarını görsel olarak tasarlamak', 'A', 'Medium'),
(6, 'en', 'Which of the following is the primary function of DNS?', 'Mapping domain names to IP addresses', 'Encrypting files', 'Increasing processor speed', 'Visually designing web pages', 'A', 'Medium'),
(6, 'es', '¿Cuál de las siguientes es la función principal del DNS?', 'Asociar nombres de dominio con direcciones IP', 'Cifrar archivos', 'Aumentar la velocidad del procesador', 'Diseñar visualmente páginas web', 'A', 'Medium'),

(6, 'tr', 'Git aşağıdakilerden hangisidir?', 'Sürüm kontrol sistemi', 'Veritabanı yönetim sistemi', 'İşletim sistemi', 'Web tarayıcısı', 'A', 'Medium'),
(6, 'en', 'Which of the following is Git?', 'Version control system', 'Database management system', 'Operating system', 'Web browser', 'A', 'Medium'),
(6, 'es', '¿Cuál de las siguientes opciones describe a Git?', 'Sistema de control de versiones', 'Sistema de gestión de bases de datos', 'Sistema operativo', 'Navegador web', 'A', 'Medium'),

(6, 'tr', 'HTTPS''nin HTTP''den temel farkı aşağıdakilerden hangisidir?', 'İletişimin TLS ile şifrelenmesini sağlaması', 'Web sitelerinin daha fazla RAM kullanmasını sağlaması', 'Yalnızca mobil cihazlarda çalışması', 'İnternet bağlantısını tamamen ortadan kaldırması', 'A', 'Medium'),
(6, 'en', 'Which of the following is the main difference between HTTPS and HTTP?', 'It provides encryption of communication using TLS', 'It makes websites use more RAM', 'It works only on mobile devices', 'It completely eliminates the internet connection', 'A', 'Medium'),
(6, 'es', '¿Cuál de las siguientes es la principal diferencia entre HTTPS y HTTP?', 'Proporciona cifrado de la comunicación mediante TLS', 'Hace que los sitios web utilicen más RAM', 'Funciona únicamente en dispositivos móviles', 'Elimina por completo la conexión a Internet', 'A', 'Medium'),

(6, 'tr', 'SQL temel olarak hangi amaçla kullanılır?', 'İlişkisel veritabanlarındaki verileri yönetmek ve sorgulamak', 'Görüntüleri düzenlemek', 'İşletim sistemi geliştirmek', 'Bilgisayar donanımı üretmek', 'A', 'Medium'),
(6, 'en', 'What is SQL primarily used for?', 'Managing and querying data in relational databases', 'Editing images', 'Developing operating systems', 'Manufacturing computer hardware', 'A', 'Medium'),
(6, 'es', '¿Para qué se utiliza principalmente SQL?', 'Gestionar y consultar datos en bases de datos relacionales', 'Editar imágenes', 'Desarrollar sistemas operativos', 'Fabricar hardware informático', 'A', 'Medium'),

(6, 'tr', 'IPv4 adresleri kaç bit uzunluğundadır?', '16', '32', '64', '128', 'B', 'Medium'),
(6, 'en', 'How many bits long are IPv4 addresses?', '16', '32', '64', '128', 'B', 'Medium'),
(6, 'es', '¿Cuántos bits de longitud tienen las direcciones IPv4?', '16', '32', '64', '128', 'B', 'Medium'),

(6, 'tr', 'Bir programın kaynak kodunu çalıştırılabilir makine koduna çeviren yazılıma ne ad verilir?', 'Derleyici', 'Tarayıcı', 'Metin düzenleyici', 'Dosya yöneticisi', 'A', 'Hard'),
(6, 'en', 'What is the software that translates a program''s source code into executable machine code called?', 'Compiler', 'Browser', 'Text editor', 'File manager', 'A', 'Hard'),
(6, 'es', '¿Cómo se llama el software que traduce el código fuente de un programa a código máquina ejecutable?', 'Compilador', 'Navegador', 'Editor de texto', 'Administrador de archivos', 'A', 'Hard'),

(6, 'tr', 'Nesne yönelimli programlamada bir sınıftan oluşturulan somut örneğe ne ad verilir?', 'Modül', 'İş parçacığı', 'Nesne', 'Derleyici', 'C', 'Hard'),
(6, 'en', 'In object-oriented programming, what is a concrete instance created from a class called?', 'Module', 'Thread', 'Object', 'Compiler', 'C', 'Hard'),
(6, 'es', 'En la programación orientada a objetos, ¿cómo se denomina una instancia concreta creada a partir de una clase?', 'Módulo', 'Hilo', 'Objeto', 'Compilador', 'C', 'Hard'),

(6, 'tr', 'REST mimarisinde istemci ile sunucu arasındaki durum bilgisinin istekler arasında sunucu tarafından tutulmaması hangi özelliği ifade eder?', 'Önbellekleme', 'Durumsuzluk', 'Şifreleme', 'Yönlendirme', 'B', 'Hard'),
(6, 'en', 'In REST architecture, which property means that the server does not retain state information between requests from the client?', 'Caching', 'Statelessness', 'Encryption', 'Routing', 'B', 'Hard'),
(6, 'es', 'En la arquitectura REST, ¿qué propiedad significa que el servidor no conserva información de estado entre las solicitudes del cliente?', 'Almacenamiento en caché', 'Ausencia de estado', 'Cifrado', 'Enrutamiento', 'B', 'Hard'),

(6, 'tr', 'Bilgisayar biliminde ''halting problem'' aşağıdaki sorulardan hangisini genel olarak ele alır?', 'Bir programın verilen girdide durup durmayacağının genel bir algoritmayla belirlenip belirlenemeyeceğini', 'Bir işlemcinin maksimum saat hızını', 'Bir ağ paketinin hangi yönlendiriciden geçeceğini', 'Bir dosyanın ne kadar depolama alanı kaplayacağını', 'A', 'Very Hard'),
(6, 'en', 'In computer science, which of the following questions does the ''halting problem'' generally address?', 'Whether it is possible to determine with a general algorithm whether a program will halt on a given input', 'The maximum clock speed of a processor', 'Which router a network packet will pass through', 'How much storage space a file will occupy', 'A', 'Very Hard'),
(6, 'es', 'En informática, ¿cuál de las siguientes preguntas aborda generalmente el ''problema de la parada''?', 'Si es posible determinar mediante un algoritmo general si un programa se detendrá con una entrada determinada', 'La velocidad máxima de reloj de un procesador', 'Por qué enrutador pasará un paquete de red', 'Cuánto espacio de almacenamiento ocupará un archivo', 'A', 'Very Hard'),

(6, 'tr', 'CAP teoremine göre dağıtık bir sistem, ağ bölünmesi gerçekleştiğinde aşağıdaki özelliklerden hangilerinin ikisini aynı anda garanti edebilir?', 'Tutarlılık ve kullanılabilirlik', 'Gecikme ve bant genişliği', 'Şifreleme ve sıkıştırma', 'Yedeklilik ve sanallaştırma', 'A', 'Very Hard'),
(6, 'en', 'According to the CAP theorem, which two of the following properties can a distributed system guarantee simultaneously when a network partition occurs?', 'Consistency and availability', 'Latency and bandwidth', 'Encryption and compression', 'Redundancy and virtualization', 'A', 'Very Hard'),
(6, 'es', 'Según el teorema CAP, ¿cuáles dos de las siguientes propiedades puede garantizar simultáneamente un sistema distribuido cuando se produce una partición de red?', 'Consistencia y disponibilidad', 'Latencia y ancho de banda', 'Cifrado y compresión', 'Redundancia y virtualización', 'A', 'Very Hard'),

-- Literature (Edebiyat)
(7, 'tr', 'İstiklal Marşı''nın şairi kimdir?', 'Yahya Kemal Beyatlı', 'Mehmet Akif Ersoy', 'Tevfik Fikret', 'Nazım Hikmet', 'B', 'Easy'),
(7, 'en', 'Who is the poet of the Turkish national anthem, ''İstiklal Marşı''?', 'Yahya Kemal Beyatlı', 'Mehmet Akif Ersoy', 'Tevfik Fikret', 'Nazım Hikmet', 'B', 'Easy'),
(7, 'es', '¿Quién es el poeta del himno nacional turco, ''İstiklal Marşı''?', 'Yahya Kemal Beyatlı', 'Mehmet Akif Ersoy', 'Tevfik Fikret', 'Nazım Hikmet', 'B', 'Easy'),

(7, 'tr', '''Sefiller'' adlı romanın yazarı kimdir?', 'Victor Hugo', 'Dostoyevski', 'Tolstoy', 'Charles Dickens', 'A', 'Easy'),
(7, 'en', 'Who is the author of the novel ''Les Misérables''?', 'Victor Hugo', 'Dostoyevsky', 'Tolstoy', 'Charles Dickens', 'A', 'Easy'),
(7, 'es', '¿Quién es el autor de la novela ''Los miserables''?', 'Victor Hugo', 'Dostoyevski', 'Tolstói', 'Charles Dickens', 'A', 'Easy'),

(7, 'tr', '''Don Kişot'' adlı eserin yazarı kimdir?', 'William Shakespeare', 'Miguel de Cervantes', 'Goethe', 'Dante Alighieri', 'B', 'Easy'),
(7, 'en', 'Who is the author of ''Don Quixote''?', 'William Shakespeare', 'Miguel de Cervantes', 'Goethe', 'Dante Alighieri', 'B', 'Easy'),
(7, 'es', '¿Quién es el autor de ''Don Quijote''?', 'William Shakespeare', 'Miguel de Cervantes', 'Goethe', 'Dante Alighieri', 'B', 'Easy'),

(7, 'tr', '''Romeo ve Juliet'' adlı eserin yazarı kimdir?', 'William Shakespeare', 'Victor Hugo', 'Molière', 'Homer', 'A', 'Easy'),
(7, 'en', 'Who is the author of ''Romeo and Juliet''?', 'William Shakespeare', 'Victor Hugo', 'Molière', 'Homer', 'A', 'Easy'),
(7, 'es', '¿Quién es el autor de ''Romeo y Julieta''?', 'William Shakespeare', 'Victor Hugo', 'Molière', 'Homero', 'A', 'Easy'),

(7, 'tr', 'Türk edebiyatında ''İnce Memed'' romanının yazarı kimdir?', 'Orhan Kemal', 'Yaşar Kemal', 'Kemal Tahir', 'Sabahattin Ali', 'B', 'Easy'),
(7, 'en', 'Who is the author of the novel ''İnce Memed'' in Turkish literature?', 'Orhan Kemal', 'Yaşar Kemal', 'Kemal Tahir', 'Sabahattin Ali', 'B', 'Easy'),
(7, 'es', '¿Quién es el autor de la novela ''İnce Memed'' de la literatura turca?', 'Orhan Kemal', 'Yaşar Kemal', 'Kemal Tahir', 'Sabahattin Ali', 'B', 'Easy'),

(7, 'tr', '''Suç ve Ceza'' adlı romanın yazarı kimdir?', 'Fyodor Dostoyevski', 'Lev Tolstoy', 'Anton Çehov', 'Nikolay Gogol', 'A', 'Easy'),
(7, 'en', 'Who is the author of the novel ''Crime and Punishment''?', 'Fyodor Dostoevsky', 'Leo Tolstoy', 'Anton Chekhov', 'Nikolai Gogol', 'A', 'Easy'),
(7, 'es', '¿Quién es el autor de la novela ''Crimen y castigo''?', 'Fiódor Dostoyevski', 'León Tolstói', 'Antón Chéjov', 'Nikolái Gógol', 'A', 'Easy'),

(7, 'tr', '''Kürk Mantolu Madonna'' adlı romanın yazarı kimdir?', 'Sabahattin Ali', 'Sait Faik Abasıyanık', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'A', 'Easy'),
(7, 'en', 'Who is the author of the novel ''Madonna in a Fur Coat''?', 'Sabahattin Ali', 'Sait Faik Abasıyanık', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'A', 'Easy'),
(7, 'es', '¿Quién es el autor de la novela ''Madonna con abrigo de piel''?', 'Sabahattin Ali', 'Sait Faik Abasıyanık', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'A', 'Easy'),

(7, 'tr', '''Çalıkuşu'' romanının yazarı kimdir?', 'Halide Edib Adıvar', 'Reşat Nuri Güntekin', 'Yakup Kadri Karaosmanoğlu', 'Refik Halit Karay', 'B', 'Easy'),
(7, 'en', 'Who is the author of the novel ''Çalıkuşu''?', 'Halide Edib Adıvar', 'Reşat Nuri Güntekin', 'Yakup Kadri Karaosmanoğlu', 'Refik Halit Karay', 'B', 'Easy'),
(7, 'es', '¿Quién es el autor de la novela ''Çalıkuşu''?', 'Halide Edib Adıvar', 'Reşat Nuri Güntekin', 'Yakup Kadri Karaosmanoğlu', 'Refik Halit Karay', 'B', 'Easy'),

(7, 'tr', '''Dönüşüm'' adlı eserin yazarı kimdir?', 'Franz Kafka', 'Albert Camus', 'George Orwell', 'Ernest Hemingway', 'A', 'Easy'),
(7, 'en', 'Who is the author of ''The Metamorphosis''?', 'Franz Kafka', 'Albert Camus', 'George Orwell', 'Ernest Hemingway', 'A', 'Easy'),
(7, 'es', '¿Quién es el autor de ''La metamorfosis''?', 'Franz Kafka', 'Albert Camus', 'George Orwell', 'Ernest Hemingway', 'A', 'Easy'),

(7, 'tr', '''1984'' adlı distopik romanın yazarı kimdir?', 'Aldous Huxley', 'George Orwell', 'Ray Bradbury', 'Jules Verne', 'B', 'Easy'),
(7, 'en', 'Who is the author of the dystopian novel ''1984''?', 'Aldous Huxley', 'George Orwell', 'Ray Bradbury', 'Jules Verne', 'B', 'Easy'),
(7, 'es', '¿Quién es el autor de la novela distópica ''1984''?', 'Aldous Huxley', 'George Orwell', 'Ray Bradbury', 'Julio Verne', 'B', 'Easy'),

(7, 'tr', '''Tutunamayanlar'' romanının yazarı kimdir?', 'Oğuz Atay', 'Orhan Pamuk', 'Yusuf Atılgan', 'Tarık Buğra', 'A', 'Medium'),
(7, 'en', 'Who is the author of the novel ''Tutunamayanlar''?', 'Oğuz Atay', 'Orhan Pamuk', 'Yusuf Atılgan', 'Tarık Buğra', 'A', 'Medium'),
(7, 'es', '¿Quién es el autor de la novela ''Tutunamayanlar''?', 'Oğuz Atay', 'Orhan Pamuk', 'Yusuf Atılgan', 'Tarık Buğra', 'A', 'Medium'),

(7, 'tr', '''Saatleri Ayarlama Enstitüsü'' adlı romanın yazarı kimdir?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Ahmet Mithat Efendi', 'Hüseyin Rahmi Gürpınar', 'A', 'Medium'),
(7, 'en', 'Who is the author of the novel ''The Time Regulation Institute''?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Ahmet Mithat Efendi', 'Hüseyin Rahmi Gürpınar', 'A', 'Medium'),
(7, 'es', '¿Quién es el autor de la novela ''El instituto de regulación del tiempo''?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Ahmet Mithat Efendi', 'Hüseyin Rahmi Gürpınar', 'A', 'Medium'),

(7, 'tr', '''Mai ve Siyah'' romanı aşağıdaki yazarlardan hangisine aittir?', 'Halit Ziya Uşaklıgil', 'Mehmet Rauf', 'Tevfik Fikret', 'Samipaşazade Sezai', 'A', 'Medium'),
(7, 'en', 'Which of the following authors wrote the novel ''Mai ve Siyah''?', 'Halit Ziya Uşaklıgil', 'Mehmet Rauf', 'Tevfik Fikret', 'Samipaşazade Sezai', 'A', 'Medium'),
(7, 'es', '¿A cuál de los siguientes autores pertenece la novela ''Mai ve Siyah''?', 'Halit Ziya Uşaklıgil', 'Mehmet Rauf', 'Tevfik Fikret', 'Samipaşazade Sezai', 'A', 'Medium'),

(7, 'tr', '''Aşk-ı Memnu'' romanının yazarı kimdir?', 'Halit Ziya Uşaklıgil', 'Recaizade Mahmut Ekrem', 'Namık Kemal', 'Şemsettin Sami', 'A', 'Medium'),
(7, 'en', 'Who is the author of the novel ''Aşk-ı Memnu''?', 'Halit Ziya Uşaklıgil', 'Recaizade Mahmut Ekrem', 'Namık Kemal', 'Şemsettin Sami', 'A', 'Medium'),
(7, 'es', '¿Quién es el autor de la novela ''Aşk-ı Memnu''?', 'Halit Ziya Uşaklıgil', 'Recaizade Mahmut Ekrem', 'Namık Kemal', 'Şemsettin Sami', 'A', 'Medium'),

(7, 'tr', 'Dünya edebiyatında ''İlahi Komedya'' adlı eserin yazarı kimdir?', 'Dante Alighieri', 'Homeros', 'Virgil', 'Boccaccio', 'A', 'Medium'),
(7, 'en', 'Who is the author of ''The Divine Comedy'' in world literature?', 'Dante Alighieri', 'Homer', 'Virgil', 'Boccaccio', 'A', 'Medium'),
(7, 'es', '¿Quién es el autor de ''La divina comedia'' en la literatura mundial?', 'Dante Alighieri', 'Homero', 'Virgilio', 'Boccaccio', 'A', 'Medium'),

(7, 'tr', 'Türk edebiyatında ''Taaşşuk-ı Talat ve Fitnat'' hangi yazarın eseridir?', 'Şemsettin Sami', 'Namık Kemal', 'Ziya Paşa', 'Ahmet Mithat Efendi', 'A', 'Hard'),
(7, 'en', 'In Turkish literature, which author wrote ''Taaşşuk-ı Talat ve Fitnat''?', 'Şemsettin Sami', 'Namık Kemal', 'Ziya Paşa', 'Ahmet Mithat Efendi', 'A', 'Hard'),
(7, 'es', 'En la literatura turca, ¿qué autor escribió ''Taaşşuk-ı Talat ve Fitnat''?', 'Şemsettin Sami', 'Namık Kemal', 'Ziya Paşa', 'Ahmet Mithat Efendi', 'A', 'Hard'),

(7, 'tr', '''Eylül'' adlı roman, Türk edebiyatında genellikle hangi özelliğiyle öne çıkar?', 'İlk psikolojik roman olarak kabul edilmesi', 'İlk köy romanı olması', 'İlk tarihi roman olması', 'İlk polisiye roman olması', 'A', 'Hard'),
(7, 'en', 'What characteristic is the novel ''Eylül'' generally known for in Turkish literature?', 'Being considered the first psychological novel', 'Being the first village novel', 'Being the first historical novel', 'Being the first detective novel', 'A', 'Hard'),
(7, 'es', '¿Por qué característica destaca generalmente la novela ''Eylül'' en la literatura turca?', 'Por ser considerada la primera novela psicológica', 'Por ser la primera novela rural', 'Por ser la primera novela histórica', 'Por ser la primera novela policíaca', 'A', 'Hard'),

(7, 'tr', '''Huzur'' romanında Mümtaz karakterinin iç dünyası ve İstanbul''un kültürel atmosferi hangi yazarın anlatımıyla işlenmiştir?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Yakup Kadri Karaosmanoğlu', 'Necip Fazıl Kısakürek', 'A', 'Hard'),
(7, 'en', 'In the novel ''Huzur'', whose narrative explores the inner world of the character Mümtaz and the cultural atmosphere of Istanbul?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Yakup Kadri Karaosmanoğlu', 'Necip Fazıl Kısakürek', 'A', 'Hard'),
(7, 'es', 'En la novela ''Huzur'', ¿qué autor desarrolla el mundo interior del personaje Mümtaz y la atmósfera cultural de Estambul?', 'Ahmet Hamdi Tanpınar', 'Peyami Safa', 'Yakup Kadri Karaosmanoğlu', 'Necip Fazıl Kısakürek', 'A', 'Hard'),

(7, 'tr', 'Dede Korkut Hikâyeleri''nin bilinen Dresden ve Vatikan nüshaları hangi Türk edebiyatı döneminin sözlü ve yazılı geleneklerini yansıtır?', 'İslamiyet öncesi Türk edebiyatı', 'Geçiş dönemi Türk edebiyatı', 'İslamiyet sonrası Türk destan geleneği', 'Tanzimat Dönemi Türk edebiyatı', 'C', 'Very Hard'),
(7, 'en', 'The known Dresden and Vatican manuscripts of the ''Book of Dede Korkut'' reflect the oral and written traditions of which period of Turkish literature?', 'Pre-Islamic Turkish literature', 'The transitional period of Turkish literature', 'The post-Islamic Turkish epic tradition', 'Tanzimat-era Turkish literature', 'C', 'Very Hard'),
(7, 'es', '¿Las conocidas copias de Dresde y del Vaticano de las ''Historias de Dede Korkut'' reflejan las tradiciones orales y escritas de qué período de la literatura turca?', 'Literatura turca preislámica', 'Literatura turca del período de transición', 'La tradición épica turca posterior al islam', 'Literatura turca del período Tanzimat', 'C', 'Very Hard'),

(7, 'tr', '''Kutadgu Bilig'' adlı eserin yazarı kimdir?', 'Kaşgarlı Mahmud', 'Yusuf Has Hacip', 'Edip Ahmet Yükneki', 'Ahmet Yesevi', 'B', 'Very Hard'),
(7, 'en', 'Who is the author of the work ''Kutadgu Bilig''?', 'Mahmud al-Kashgari', 'Yusuf Has Hacip', 'Edip Ahmet Yükneki', 'Ahmet Yesevi', 'B', 'Very Hard'),
(7, 'es', '¿Quién es el autor de la obra ''Kutadgu Bilig''?', 'Mahmud al-Kashgari', 'Yusuf Has Hacip', 'Edip Ahmet Yükneki', 'Ahmet Yesevi', 'B', 'Very Hard'),
-- Music (Müzik)
(8, 'tr', 'Piyanoda kaç beyaz tuş bulunur?', '44', '52', '61', '88', 'B', 'Easy'),
(8, 'en', 'How many white keys are there on a piano?', '44', '52', '61', '88', 'B', 'Easy'),
(8, 'es', '¿Cuántas teclas blancas tiene un piano?', '44', '52', '61', '88', 'B', 'Easy'),

(8, 'tr', 'Bir orkestrada yaylı çalgılardan biri aşağıdakilerden hangisidir?', 'Keman', 'Trompet', 'Flüt', 'Klarnet', 'A', 'Easy'),
(8, 'en', 'Which of the following is a string instrument in an orchestra?', 'Violin', 'Trumpet', 'Flute', 'Clarinet', 'A', 'Easy'),
(8, 'es', '¿Cuál de los siguientes es un instrumento de cuerda en una orquesta?', 'Violín', 'Trompeta', 'Flauta', 'Clarinete', 'A', 'Easy'),

(8, 'tr', 'Müzikte seslerin belirli bir düzen içinde sıralanmasına ne ad verilir?', 'Ritim', 'Melodi', 'Tempo', 'Tını', 'B', 'Easy'),
(8, 'en', 'What is the arrangement of sounds in a specific sequence in music called?', 'Rhythm', 'Melody', 'Tempo', 'Timbre', 'B', 'Easy'),
(8, 'es', '¿Cómo se llama la organización de los sonidos en una secuencia determinada en la música?', 'Ritmo', 'Melodía', 'Tempo', 'Timbre', 'B', 'Easy'),

(8, 'tr', 'Aşağıdakilerden hangisi vurmalı bir çalgıdır?', 'Keman', 'Piyano', 'Davul', 'Flüt', 'C', 'Easy'),
(8, 'en', 'Which of the following is a percussion instrument?', 'Violin', 'Piano', 'Drum', 'Flute', 'C', 'Easy'),
(8, 'es', '¿Cuál de los siguientes es un instrumento de percusión?', 'Violín', 'Piano', 'Tambor', 'Flauta', 'C', 'Easy'),

(8, 'tr', 'Müzikte bir eserin hızını belirten terim aşağıdakilerden hangisidir?', 'Tempo', 'Tını', 'Armoni', 'Akor', 'A', 'Easy'),
(8, 'en', 'Which term indicates the speed of a musical piece?', 'Tempo', 'Timbre', 'Harmony', 'Chord', 'A', 'Easy'),
(8, 'es', '¿Qué término indica la velocidad de una obra musical?', 'Tempo', 'Timbre', 'Armonía', 'Acorde', 'A', 'Easy'),

(8, 'tr', 'Bağlama hangi çalgı ailesine aittir?', 'Yaylı çalgılar', 'Telli çalgılar', 'Üflemeli çalgılar', 'Vurmalı çalgılar', 'B', 'Easy'),
(8, 'en', 'Which family of instruments does the bağlama belong to?', 'String instruments', 'Plucked string instruments', 'Wind instruments', 'Percussion instruments', 'B', 'Easy'),
(8, 'es', '¿A qué familia de instrumentos pertenece el bağlama?', 'Instrumentos de cuerda frotada', 'Instrumentos de cuerda pulsada', 'Instrumentos de viento', 'Instrumentos de percusión', 'B', 'Easy'),

(8, 'tr', 'Türk halk müziğinde ''uzun hava'' genel olarak hangi özelliğiyle tanınır?', 'Serbest ritimli olması', 'Yalnızca davulla çalınması', 'Sadece enstrümantal olması', 'Çok hızlı tempoda söylenmesi', 'A', 'Easy'),
(8, 'en', 'In Turkish folk music, what characteristic is ''uzun hava'' generally known for?', 'Having a free rhythm', 'Being played only with a drum', 'Being purely instrumental', 'Being performed at a very fast tempo', 'A', 'Easy'),
(8, 'es', 'En la música folclórica turca, ¿por qué característica se conoce generalmente el ''uzun hava''?', 'Por tener un ritmo libre', 'Por interpretarse únicamente con un tambor', 'Por ser exclusivamente instrumental', 'Por cantarse a un tempo muy rápido', 'A', 'Easy'),

(8, 'tr', 'Müzikte iki veya daha fazla sesin aynı anda duyulmasıyla oluşan yapıya ne ad verilir?', 'Akor', 'Tempo', 'Ritim', 'Nota', 'A', 'Easy'),
(8, 'en', 'What is the structure formed by two or more notes sounding simultaneously in music called?', 'Chord', 'Tempo', 'Rhythm', 'Note', 'A', 'Easy'),
(8, 'es', '¿Cómo se llama la estructura formada por dos o más sonidos que se escuchan simultáneamente en la música?', 'Acorde', 'Tempo', 'Ritmo', 'Nota', 'A', 'Easy'),

(8, 'tr', 'Ludwig van Beethoven hangi ülkenin Bonn şehrinde doğmuştur?', 'Almanya', 'İtalya', 'Avusturya', 'Fransa', 'A', 'Easy'),
(8, 'en', 'In which country was Ludwig van Beethoven born in the city of Bonn?', 'Germany', 'Italy', 'Austria', 'France', 'A', 'Easy'),
(8, 'es', '¿En qué país nació Ludwig van Beethoven, en la ciudad de Bonn?', 'Alemania', 'Italia', 'Austria', 'Francia', 'A', 'Easy'),

(8, 'tr', 'Wolfgang Amadeus Mozart hangi sanat dalında tanınmış bir bestecidir?', 'Resim', 'Heykel', 'Müzik', 'Mimari', 'C', 'Easy'),
(8, 'en', 'In which art form is Wolfgang Amadeus Mozart known as a famous composer?', 'Painting', 'Sculpture', 'Music', 'Architecture', 'C', 'Easy'),
(8, 'es', '¿En qué disciplina artística es conocido Wolfgang Amadeus Mozart como un famoso compositor?', 'Pintura', 'Escultura', 'Música', 'Arquitectura', 'C', 'Easy'),

(8, 'tr', 'Bir müzik eserinin ses yüksekliğinin giderek artmasına ne ad verilir?', 'Diminuendo', 'Crescendo', 'Staccato', 'Legato', 'B', 'Medium'),
(8, 'en', 'What is the gradual increase in the loudness of a musical piece called?', 'Diminuendo', 'Crescendo', 'Staccato', 'Legato', 'B', 'Medium'),
(8, 'es', '¿Cómo se llama el aumento gradual de la intensidad sonora de una obra musical?', 'Diminuendo', 'Crescendo', 'Staccato', 'Legato', 'B', 'Medium'),

(8, 'tr', 'Aşağıdakilerden hangisi üflemeli bir çalgıdır?', 'Viyolonsel', 'Obua', 'Kontrbas', 'Timpani', 'B', 'Medium'),
(8, 'en', 'Which of the following is a wind instrument?', 'Cello', 'Oboe', 'Double bass', 'Timpani', 'B', 'Medium'),
(8, 'es', '¿Cuál de los siguientes es un instrumento de viento?', 'Violonchelo', 'Oboe', 'Contrabajo', 'Timbales', 'B', 'Medium'),

(8, 'tr', 'Bir oktav kaç doğal nota içerir?', '5', '6', '7', '8', 'C', 'Medium'),
(8, 'en', 'How many natural notes does an octave contain?', '5', '6', '7', '8', 'C', 'Medium'),
(8, 'es', '¿Cuántas notas naturales contiene una octava?', '5', '6', '7', '8', 'C', 'Medium'),

(8, 'tr', 'Johann Sebastian Bach hangi müzik döneminin önemli bestecilerinden biridir?', 'Barok', 'Klasik', 'Romantik', 'Empresyonist', 'A', 'Medium'),
(8, 'en', 'Johann Sebastian Bach is one of the important composers of which musical period?', 'Baroque', 'Classical', 'Romantic', 'Impressionist', 'A', 'Medium'),
(8, 'es', '¿Johann Sebastian Bach es uno de los compositores importantes de qué período musical?', 'Barroco', 'Clásico', 'Romántico', 'Impresionista', 'A', 'Medium'),

(8, 'tr', 'Müzikte ''forte'' terimi neyi ifade eder?', 'Yavaş çalmayı', 'Güçlü ve yüksek sesle çalmayı', 'Hızlı çalmayı', 'Kesik çalmayı', 'B', 'Medium'),
(8, 'en', 'What does the term ''forte'' mean in music?', 'Playing slowly', 'Playing strongly and loudly', 'Playing quickly', 'Playing detached', 'B', 'Medium'),
(8, 'es', '¿Qué significa el término ''forte'' en música?', 'Tocar lentamente', 'Tocar con fuerza y a un volumen alto', 'Tocar rápidamente', 'Tocar de forma entrecortada', 'B', 'Medium'),

(8, 'tr', 'Bir senfonik orkestrada yaylı çalgılar ailesinin en kalın sesli standart üyesi hangisidir?', 'Viyola', 'Viyolonsel', 'Kontrbas', 'Keman', 'C', 'Hard'),
(8, 'en', 'Which is the lowest-pitched standard member of the string family in a symphony orchestra?', 'Viola', 'Cello', 'Double bass', 'Violin', 'C', 'Hard'),
(8, 'es', '¿Cuál es el miembro estándar de registro más grave de la familia de cuerda en una orquesta sinfónica?', 'Viola', 'Violonchelo', 'Contrabajo', 'Violín', 'C', 'Hard'),

(8, 'tr', 'Antonio Vivaldi''nin en tanınmış eserlerinden biri olan ''Dört Mevsim'' hangi türde bestelenmiştir?', 'Konçerto', 'Opera', 'Senfoni', 'Oratoryo', 'A', 'Hard'),
(8, 'en', 'In which genre was Antonio Vivaldi''s famous work ''The Four Seasons'' composed?', 'Concerto', 'Opera', 'Symphony', 'Oratorio', 'A', 'Hard'),
(8, 'es', '¿En qué género fue compuesta ''Las cuatro estaciones'', una de las obras más famosas de Antonio Vivaldi?', 'Concierto', 'Ópera', 'Sinfonía', 'Oratorio', 'A', 'Hard'),

(8, 'tr', 'Müzikte bir temanın farklı ses yüksekliklerinde art arda tekrarlanmasına dayanan kontrpuan tekniği aşağıdakilerden hangisidir?', 'Füg', 'Rondo', 'Sonat', 'Arya', 'A', 'Hard'),
(8, 'en', 'Which of the following is the counterpoint technique based on the successive repetition of a theme at different pitches?', 'Fugue', 'Rondo', 'Sonata', 'Aria', 'A', 'Hard'),
(8, 'es', '¿Cuál de las siguientes es la técnica de contrapunto basada en la repetición sucesiva de un tema en diferentes alturas?', 'Fuga', 'Rondó', 'Sonata', 'Aria', 'A', 'Hard'),

(8, 'tr', 'Batı müziğinde bir majör dizinin üçüncü derecesinin bemol yapılmasıyla oluşan dizi aşağıdakilerden hangisidir?', 'Doğal minör dizi', 'Armonik minör dizi', 'Melodik minör dizi', 'Pentatonik dizi', 'A', 'Very Hard'),
(8, 'en', 'Which of the following scales is formed in Western music by flattening the third degree of a major scale?', 'Natural minor scale', 'Harmonic minor scale', 'Melodic minor scale', 'Pentatonic scale', 'A', 'Very Hard'),
(8, 'es', '¿Cuál de las siguientes escalas se forma en la música occidental al bajar un semitono el tercer grado de una escala mayor?', 'Escala menor natural', 'Escala menor armónica', 'Escala menor melódica', 'Escala pentatónica', 'A', 'Very Hard'),

(8, 'tr', 'Bir müzik eserinde ana tonalitenin dışında geçici olarak başka bir tonalite merkezinin öne çıkmasına ne ad verilir?', 'Modülasyon', 'Senkop', 'Artikülasyon', 'Polifoni', 'A', 'Very Hard'),
(8, 'en', 'What is the temporary emphasis of another tonal center outside the main tonality in a musical work called?', 'Modulation', 'Syncopation', 'Articulation', 'Polyphony', 'A', 'Very Hard'),
(8, 'es', '¿Cómo se llama el énfasis temporal de otro centro tonal fuera de la tonalidad principal en una obra musical?', 'Modulación', 'Síncopa', 'Articulación', 'Polifonía', 'A', 'Very Hard'),
-- Movies (Sinema)
(9, 'tr', 'Titanic filminin yönetmeni kimdir?', 'Steven Spielberg', 'James Cameron', 'Christopher Nolan', 'Ridley Scott', 'B', 'Easy'),
(9, 'en', 'Who directed the film Titanic?', 'Steven Spielberg', 'James Cameron', 'Christopher Nolan', 'Ridley Scott', 'B', 'Easy'),
(9, 'es', '¿Quién dirigió la película Titanic?', 'Steven Spielberg', 'James Cameron', 'Christopher Nolan', 'Ridley Scott', 'B', 'Easy'),

(9, 'tr', 'The Godfather filminin yönetmeni kimdir?', 'Martin Scorsese', 'Francis Ford Coppola', 'Quentin Tarantino', 'Stanley Kubrick', 'B', 'Easy'),
(9, 'en', 'Who directed the film The Godfather?', 'Martin Scorsese', 'Francis Ford Coppola', 'Quentin Tarantino', 'Stanley Kubrick', 'B', 'Easy'),
(9, 'es', '¿Quién dirigió la película The Godfather?', 'Martin Scorsese', 'Francis Ford Coppola', 'Quentin Tarantino', 'Stanley Kubrick', 'B', 'Easy'),

(9, 'tr', 'Harry Potter film serisinde Harry Potter karakterini kim canlandırmıştır?', 'Daniel Radcliffe', 'Rupert Grint', 'Tom Felton', 'Elijah Wood', 'A', 'Easy'),
(9, 'en', 'Who portrayed Harry Potter in the Harry Potter film series?', 'Daniel Radcliffe', 'Rupert Grint', 'Tom Felton', 'Elijah Wood', 'A', 'Easy'),
(9, 'es', '¿Quién interpretó a Harry Potter en la saga cinematográfica de Harry Potter?', 'Daniel Radcliffe', 'Rupert Grint', 'Tom Felton', 'Elijah Wood', 'A', 'Easy'),

(9, 'tr', 'The Lord of the Rings film üçlemesinde Frodo Baggins karakterini kim canlandırmıştır?', 'Orlando Bloom', 'Ian McKellen', 'Elijah Wood', 'Viggo Mortensen', 'C', 'Easy'),
(9, 'en', 'Who portrayed Frodo Baggins in The Lord of the Rings film trilogy?', 'Orlando Bloom', 'Ian McKellen', 'Elijah Wood', 'Viggo Mortensen', 'C', 'Easy'),
(9, 'es', '¿Quién interpretó a Frodo Bolsón en la trilogía cinematográfica de The Lord of the Rings?', 'Orlando Bloom', 'Ian McKellen', 'Elijah Wood', 'Viggo Mortensen', 'C', 'Easy'),

(9, 'tr', 'Jurassic Park filminde temel olarak hangi canlıların yeniden hayata döndürülmesi konu edilir?', 'Mamutlar', 'Dinozorlar', 'Dev köpekbalıkları', 'Ejderhalar', 'B', 'Easy'),
(9, 'en', 'What type of creatures are primarily brought back to life in the film Jurassic Park?', 'Mammoths', 'Dinosaurs', 'Giant sharks', 'Dragons', 'B', 'Easy'),
(9, 'es', '¿Qué tipo de criaturas son principalmente devueltas a la vida en la película Jurassic Park?', 'Mamuts', 'Dinosaurios', 'Tiburones gigantes', 'Dragones', 'B', 'Easy'),

(9, 'tr', 'Toy Story filmi hangi animasyon stüdyosu tarafından yapılmıştır?', 'DreamWorks Animation', 'Pixar', 'Studio Ghibli', 'Warner Bros. Animation', 'B', 'Easy'),
(9, 'en', 'Which animation studio produced the film Toy Story?', 'DreamWorks Animation', 'Pixar', 'Studio Ghibli', 'Warner Bros. Animation', 'B', 'Easy'),
(9, 'es', '¿Qué estudio de animación produjo la película Toy Story?', 'DreamWorks Animation', 'Pixar', 'Studio Ghibli', 'Warner Bros. Animation', 'B', 'Easy'),

(9, 'tr', 'Star Wars serisinde Darth Vader''ın oğlu kimdir?', 'Luke Skywalker', 'Han Solo', 'Obi-Wan Kenobi', 'Lando Calrissian', 'A', 'Easy'),
(9, 'en', 'Who is Darth Vader''s son in the Star Wars series?', 'Luke Skywalker', 'Han Solo', 'Obi-Wan Kenobi', 'Lando Calrissian', 'A', 'Easy'),
(9, 'es', '¿Quién es el hijo de Darth Vader en la saga Star Wars?', 'Luke Skywalker', 'Han Solo', 'Obi-Wan Kenobi', 'Lando Calrissian', 'A', 'Easy'),

(9, 'tr', 'Forrest Gump filminde başrol karakterini hangi oyuncu canlandırmıştır?', 'Tom Hanks', 'Brad Pitt', 'Tom Cruise', 'Robin Williams', 'A', 'Easy'),
(9, 'en', 'Which actor played the lead character in the film Forrest Gump?', 'Tom Hanks', 'Brad Pitt', 'Tom Cruise', 'Robin Williams', 'A', 'Easy'),
(9, 'es', '¿Qué actor interpretó al personaje principal en la película Forrest Gump?', 'Tom Hanks', 'Brad Pitt', 'Tom Cruise', 'Robin Williams', 'A', 'Easy'),

(9, 'tr', 'The Matrix filminde Neo karakterini kim canlandırmıştır?', 'Keanu Reeves', 'Christian Bale', 'Hugh Jackman', 'Matt Damon', 'A', 'Easy'),
(9, 'en', 'Who portrayed Neo in the film The Matrix?', 'Keanu Reeves', 'Christian Bale', 'Hugh Jackman', 'Matt Damon', 'A', 'Easy'),
(9, 'es', '¿Quién interpretó a Neo en la película The Matrix?', 'Keanu Reeves', 'Christian Bale', 'Hugh Jackman', 'Matt Damon', 'A', 'Easy'),

(9, 'tr', 'The Dark Knight filminde Batman karakterini kim canlandırmıştır?', 'Ben Affleck', 'Christian Bale', 'Michael Keaton', 'George Clooney', 'B', 'Easy'),
(9, 'en', 'Who portrayed Batman in the film The Dark Knight?', 'Ben Affleck', 'Christian Bale', 'Michael Keaton', 'George Clooney', 'B', 'Easy'),
(9, 'es', '¿Quién interpretó a Batman en la película The Dark Knight?', 'Ben Affleck', 'Christian Bale', 'Michael Keaton', 'George Clooney', 'B', 'Easy'),

(9, 'tr', 'Schindler''s List filminin yönetmeni kimdir?', 'Steven Spielberg', 'David Fincher', 'James Cameron', 'Peter Jackson', 'A', 'Medium'),
(9, 'en', 'Who directed the film Schindler''s List?', 'Steven Spielberg', 'David Fincher', 'James Cameron', 'Peter Jackson', 'A', 'Medium'),
(9, 'es', '¿Quién dirigió la película Schindler''s List?', 'Steven Spielberg', 'David Fincher', 'James Cameron', 'Peter Jackson', 'A', 'Medium'),

(9, 'tr', 'Inception filminin yönetmeni kimdir?', 'Denis Villeneuve', 'Christopher Nolan', 'David Lynch', 'Tim Burton', 'B', 'Medium'),
(9, 'en', 'Who directed the film Inception?', 'Denis Villeneuve', 'Christopher Nolan', 'David Lynch', 'Tim Burton', 'B', 'Medium'),
(9, 'es', '¿Quién dirigió la película Inception?', 'Denis Villeneuve', 'Christopher Nolan', 'David Lynch', 'Tim Burton', 'B', 'Medium'),

(9, 'tr', 'Pulp Fiction filminin yönetmeni kimdir?', 'Quentin Tarantino', 'Guy Ritchie', 'Martin Scorsese', 'Coen Kardeşler', 'A', 'Medium'),
(9, 'en', 'Who directed the film Pulp Fiction?', 'Quentin Tarantino', 'Guy Ritchie', 'Martin Scorsese', 'Coen Brothers', 'A', 'Medium'),
(9, 'es', '¿Quién dirigió la película Pulp Fiction?', 'Quentin Tarantino', 'Guy Ritchie', 'Martin Scorsese', 'Hermanos Coen', 'A', 'Medium'),

(9, 'tr', 'Parasite filmi hangi ülkenin yapımıdır?', 'Japonya', 'Çin', 'Güney Kore', 'Tayland', 'C', 'Medium'),
(9, 'en', 'Which country produced the film Parasite?', 'Japan', 'China', 'South Korea', 'Thailand', 'C', 'Medium'),
(9, 'es', '¿De qué país es la película Parasite?', 'Japón', 'China', 'Corea del Sur', 'Tailandia', 'C', 'Medium'),

(9, 'tr', 'The Silence of the Lambs filmindeki Hannibal Lecter karakterini hangi oyuncu canlandırmıştır?', 'Anthony Hopkins', 'Jack Nicholson', 'Gary Oldman', 'Mads Mikkelsen', 'A', 'Medium'),
(9, 'en', 'Which actor portrayed Hannibal Lecter in The Silence of the Lambs?', 'Anthony Hopkins', 'Jack Nicholson', 'Gary Oldman', 'Mads Mikkelsen', 'A', 'Medium'),
(9, 'es', '¿Qué actor interpretó a Hannibal Lecter en The Silence of the Lambs?', 'Anthony Hopkins', 'Jack Nicholson', 'Gary Oldman', 'Mads Mikkelsen', 'A', 'Medium'),

(9, 'tr', 'Akira Kurosawa''nın yönettiği ve 1954 yılında yayımlanan film hangisidir?', 'Rashomon', 'Yedi Samuray', 'Ran', 'Ikiru', 'B', 'Hard'),
(9, 'en', 'Which film directed by Akira Kurosawa was released in 1954?', 'Rashomon', 'Seven Samurai', 'Ran', 'Ikiru', 'B', 'Hard'),
(9, 'es', '¿Cuál de las siguientes películas, dirigida por Akira Kurosawa, se estrenó en 1954?', 'Rashomon', 'Los siete samuráis', 'Ran', 'Ikiru', 'B', 'Hard'),

(9, 'tr', '2001: A Space Odyssey filminin yönetmeni kimdir?', 'Stanley Kubrick', 'Arthur C. Clarke', 'Ridley Scott', 'George Lucas', 'A', 'Hard'),
(9, 'en', 'Who directed the film 2001: A Space Odyssey?', 'Stanley Kubrick', 'Arthur C. Clarke', 'Ridley Scott', 'George Lucas', 'A', 'Hard'),
(9, 'es', '¿Quién dirigió la película 2001: A Space Odyssey?', 'Stanley Kubrick', 'Arthur C. Clarke', 'Ridley Scott', 'George Lucas', 'A', 'Hard'),

(9, 'tr', 'The Good, the Bad and the Ugly filmi hangi sinema türünün klasik örneklerinden biridir?', 'Film noir', 'Spagetti western', 'Bilim kurgu', 'Müzikal', 'B', 'Hard'),
(9, 'en', 'The Good, the Bad and the Ugly is a classic example of which film genre?', 'Film noir', 'Spaghetti Western', 'Science fiction', 'Musical', 'B', 'Hard'),
(9, 'es', '¿The Good, the Bad and the Ugly es un ejemplo clásico de qué género cinematográfico?', 'Cine negro', 'Spaghetti western', 'Ciencia ficción', 'Musical', 'B', 'Hard'),

(9, 'tr', 'Federico Fellini''nin yönettiği 8½ filmi ağırlıklı olarak hangi konu etrafında şekillenir?', 'Bir yönetmenin yaratıcı krizi ve film yapma süreci', 'Bir uzay savaşının başlaması', 'Bir dedektifin cinayet soruşturması', 'Bir savaş gemisinin yolculuğu', 'A', 'Very Hard'),
(9, 'en', 'What is Federico Fellini''s film 8½ primarily centered around?', 'A filmmaker''s creative crisis and the filmmaking process', 'The beginning of a space war', 'A detective''s murder investigation', 'The journey of a warship', 'A', 'Very Hard'),
(9, 'es', '¿En torno a qué tema gira principalmente la película 8½, dirigida por Federico Fellini?', 'La crisis creativa de un director y el proceso de hacer una película', 'El comienzo de una guerra espacial', 'La investigación de un asesinato por parte de un detective', 'El viaje de un buque de guerra', 'A', 'Very Hard'),

(9, 'tr', 'Alfred Hitchcock''un Vertigo filminde baş karakter Scottie Ferguson''u hangi oyuncu canlandırmıştır?', 'James Stewart', 'Cary Grant', 'Gregory Peck', 'Humphrey Bogart', 'A', 'Very Hard'),
(9, 'en', 'Which actor portrayed the main character Scottie Ferguson in Alfred Hitchcock''s film Vertigo?', 'James Stewart', 'Cary Grant', 'Gregory Peck', 'Humphrey Bogart', 'A', 'Very Hard'),
(9, 'es', '¿Qué actor interpretó al personaje principal Scottie Ferguson en la película Vertigo de Alfred Hitchcock?', 'James Stewart', 'Cary Grant', 'Gregory Peck', 'Humphrey Bogart', 'A', 'Very Hard'),
-- Game
(10, 'tr', 'Minecraft oyununda temel yapı malzemelerinden biri olan odun elde etmek için hangi kaynak kullanılır?', 'Ağaç', 'Taş', 'Demir cevheri', 'Kum', 'A', 'Easy'),
(10, 'en', 'Which resource is used to obtain wood, one of the basic building materials in Minecraft?', 'Tree', 'Stone', 'Iron ore', 'Sand', 'A', 'Easy'),
(10, 'es', '¿Qué recurso se utiliza para obtener madera, uno de los materiales básicos de construcción en Minecraft?', 'Árbol', 'Piedra', 'Mineral de hierro', 'Arena', 'A', 'Easy'),

(10, 'tr', 'Super Mario karakterinin üzerinde bulunduğu oyun serisinin adı aşağıdakilerden hangisidir?', 'The Legend of Zelda', 'Super Mario', 'Donkey Kong', 'Kirby', 'B', 'Easy'),
(10, 'en', 'Which of the following is the name of the game series featuring the character Super Mario?', 'The Legend of Zelda', 'Super Mario', 'Donkey Kong', 'Kirby', 'B', 'Easy'),
(10, 'es', '¿Cuál de las siguientes es la serie de videojuegos en la que aparece el personaje Super Mario?', 'The Legend of Zelda', 'Super Mario', 'Donkey Kong', 'Kirby', 'B', 'Easy'),

(10, 'tr', 'Tetris oyununda temel amaç aşağıdakilerden hangisidir?', 'Aynı renkteki dört taşı birleştirmek', 'Düşen blokları yatay çizgiler oluşturacak şekilde tamamlamak', 'Rakip karakterleri yenmek', 'Bir haritada gizli eşyaları bulmak', 'B', 'Easy'),
(10, 'en', 'What is the main objective in the game Tetris?', 'Combining four blocks of the same color', 'Completing horizontal lines with falling blocks', 'Defeating opposing characters', 'Finding hidden items on a map', 'B', 'Easy'),
(10, 'es', '¿Cuál es el objetivo principal del juego Tetris?', 'Combinar cuatro piezas del mismo color', 'Completar líneas horizontales con los bloques que caen', 'Derrotar a los personajes rivales', 'Encontrar objetos ocultos en un mapa', 'B', 'Easy'),

(10, 'tr', 'The Legend of Zelda serisinin ana karakteri kimdir?', 'Mario', 'Link', 'Kirby', 'Samus', 'B', 'Easy'),
(10, 'en', 'Who is the main character of The Legend of Zelda series?', 'Mario', 'Link', 'Kirby', 'Samus', 'B', 'Easy'),
(10, 'es', '¿Quién es el personaje principal de la serie The Legend of Zelda?', 'Mario', 'Link', 'Kirby', 'Samus', 'B', 'Easy'),

(10, 'tr', 'Pokémon oyunlarında oyuncuların yakalayıp eğittiği yaratıklara ne ad verilir?', 'Digimon', 'Pokémon', 'Titans', 'Guardians', 'B', 'Easy'),
(10, 'en', 'What are the creatures that players catch and train in Pokémon games called?', 'Digimon', 'Pokémon', 'Titans', 'Guardians', 'B', 'Easy'),
(10, 'es', '¿Cómo se llaman las criaturas que los jugadores capturan y entrenan en los juegos de Pokémon?', 'Digimon', 'Pokémon', 'Titanes', 'Guardianes', 'B', 'Easy'),

(10, 'tr', 'Minecraft''ta oyunun temel dünyasında oyuncunun başlangıçta sahip olduğu karakter varsayılan olarak hangi isimle bilinir?', 'Alex', 'Steve', 'Herobrine', 'Notch', 'B', 'Easy'),
(10, 'en', 'In Minecraft, by what name is the character the player initially has in the main game world known by default?', 'Alex', 'Steve', 'Herobrine', 'Notch', 'B', 'Easy'),
(10, 'es', 'En Minecraft, ¿con qué nombre se conoce por defecto al personaje que el jugador tiene inicialmente en el mundo principal del juego?', 'Alex', 'Steve', 'Herobrine', 'Notch', 'B', 'Easy'),

(10, 'tr', 'Counter-Strike serisinde oyuncular temel olarak hangi iki takım arasında mücadele eder?', 'Askerler ve zombiler', 'Teröristler ve anti-teröristler', 'Robotlar ve insanlar', 'Polisler ve korsanlar', 'B', 'Easy'),
(10, 'en', 'In the Counter-Strike series, which two teams do players primarily compete between?', 'Soldiers and zombies', 'Terrorists and counter-terrorists', 'Robots and humans', 'Police officers and pirates', 'B', 'Easy'),
(10, 'es', 'En la serie Counter-Strike, ¿entre qué dos equipos compiten principalmente los jugadores?', 'Soldados y zombis', 'Terroristas y antiterroristas', 'Robots y humanos', 'Policías y piratas', 'B', 'Easy'),

(10, 'tr', 'Pac-Man oyununda oyuncunun temel amacı aşağıdakilerden hangisidir?', 'Labirentteki noktaları toplamak', 'Rakip oyuncuları vurmak', 'Bir şehir inşa etmek', 'Araç yarışı kazanmak', 'A', 'Easy'),
(10, 'en', 'What is the main objective of the player in Pac-Man?', 'Collecting the dots in the maze', 'Shooting opposing players', 'Building a city', 'Winning a vehicle race', 'A', 'Easy'),
(10, 'es', '¿Cuál es el objetivo principal del jugador en Pac-Man?', 'Recoger los puntos del laberinto', 'Disparar a los jugadores rivales', 'Construir una ciudad', 'Ganar una carrera de vehículos', 'A', 'Easy'),

(10, 'tr', 'The Sims serisinde oyuncular temel olarak neyi yönetir?', 'Bir futbol takımını', 'Sanal karakterlerin yaşamlarını', 'Bir uzay gemisini', 'Bir yarış arabasını', 'B', 'Easy'),
(10, 'en', 'What do players primarily manage in The Sims series?', 'A football team', 'The lives of virtual characters', 'A spaceship', 'A race car', 'B', 'Easy'),
(10, 'es', '¿Qué gestionan principalmente los jugadores en la serie The Sims?', 'Un equipo de fútbol', 'La vida de personajes virtuales', 'Una nave espacial', 'Un coche de carreras', 'B', 'Easy'),

(10, 'tr', 'FIFA serisi hangi spor dalını temel alan video oyunlarıyla tanınmıştır?', 'Basketbol', 'Tenis', 'Futbol', 'Beyzbol', 'C', 'Easy'),
(10, 'en', 'The FIFA series is known for video games based on which sport?', 'Basketball', 'Tennis', 'Football', 'Baseball', 'C', 'Easy'),
(10, 'es', '¿Por qué deporte son conocidos los videojuegos de la serie FIFA?', 'Baloncesto', 'Tenis', 'Fútbol', 'Béisbol', 'C', 'Easy'),

(10, 'tr', 'Dark Souls serisi özellikle hangi oyun özelliğiyle tanınır?', 'Çok düşük zorluk seviyesi', 'Zorlu mücadeleleri ve dikkat gerektiren oynanışı', 'Yalnızca bulmaca çözmeye dayanması', 'Sadece çevrim içi oynanabilmesi', 'B', 'Medium'),
(10, 'en', 'What game feature is the Dark Souls series particularly known for?', 'A very low difficulty level', 'Challenging combat and gameplay that requires careful attention', 'Being based solely on puzzle solving', 'Being playable only online', 'B', 'Medium'),
(10, 'es', '¿Por qué característica de juego es especialmente conocida la serie Dark Souls?', 'Un nivel de dificultad muy bajo', 'Combates difíciles y una jugabilidad que requiere mucha atención', 'Basarse únicamente en la resolución de acertijos', 'Poder jugarse únicamente en línea', 'B', 'Medium'),

(10, 'tr', 'The Witcher 3: Wild Hunt oyununda oyuncunun kontrol ettiği ana karakter kimdir?', 'Arthur Morgan', 'Geralt of Rivia', 'Ezio Auditore', 'Kratos', 'B', 'Medium'),
(10, 'en', 'Who is the main character controlled by the player in The Witcher 3: Wild Hunt?', 'Arthur Morgan', 'Geralt of Rivia', 'Ezio Auditore', 'Kratos', 'B', 'Medium'),
(10, 'es', '¿Quién es el personaje principal que controla el jugador en The Witcher 3: Wild Hunt?', 'Arthur Morgan', 'Geralt of Rivia', 'Ezio Auditore', 'Kratos', 'B', 'Medium'),

(10, 'tr', 'Grand Theft Auto V''de aşağıdaki karakterlerden hangisi oynanabilir ana karakterlerden biridir?', 'Trevor Philips', 'Joel Miller', 'Nathan Drake', 'Aloy', 'A', 'Medium'),
(10, 'en', 'Which of the following characters is one of the playable main characters in Grand Theft Auto V?', 'Trevor Philips', 'Joel Miller', 'Nathan Drake', 'Aloy', 'A', 'Medium'),
(10, 'es', '¿Cuál de los siguientes personajes es uno de los personajes principales jugables de Grand Theft Auto V?', 'Trevor Philips', 'Joel Miller', 'Nathan Drake', 'Aloy', 'A', 'Medium'),

(10, 'tr', 'Among Us oyununda oyuncuların arasına gizlice karışan ve görevleri sabote eden karakterlere ne ad verilir?', 'Avcılar', 'Impostorlar', 'Muhafızlar', 'Komutanlar', 'B', 'Medium'),
(10, 'en', 'What are the characters called in Among Us who secretly blend in with the players and sabotage tasks?', 'Hunters', 'Impostors', 'Guardians', 'Commanders', 'B', 'Medium'),
(10, 'es', '¿Cómo se llaman los personajes de Among Us que se infiltran en secreto entre los jugadores y sabotean las tareas?', 'Cazadores', 'Impostores', 'Guardianes', 'Comandantes', 'B', 'Medium'),

(10, 'tr', 'Portal oyun serisinde oyuncunun çevrede hareket etmek için kullandığı temel araç hangisidir?', 'Portal Gun', 'Gravity Gun', 'BFG', 'Hidden Blade', 'A', 'Medium'),
(10, 'en', 'What is the main tool used by the player to move around the environment in the Portal series?', 'Portal Gun', 'Gravity Gun', 'BFG', 'Hidden Blade', 'A', 'Medium'),
(10, 'es', '¿Cuál es la herramienta principal que utiliza el jugador para desplazarse por el entorno en la serie Portal?', 'Portal Gun', 'Gravity Gun', 'BFG', 'Hidden Blade', 'A', 'Medium'),

(10, 'tr', 'The Legend of Zelda: Ocarina of Time oyununda ana karakter Link''in kullandığı zaman yolculuğuyla ilişkili temel eşya hangisidir?', 'Master Sword', 'Ocarina of Time', 'Hylian Shield', 'Hookshot', 'B', 'Hard'),
(10, 'en', 'In The Legend of Zelda: Ocarina of Time, which key item used by the main character Link is associated with time travel?', 'Master Sword', 'Ocarina of Time', 'Hylian Shield', 'Hookshot', 'B', 'Hard'),
(10, 'es', 'En The Legend of Zelda: Ocarina of Time, ¿qué objeto principal utilizado por el protagonista Link está relacionado con los viajes en el tiempo?', 'Master Sword', 'Ocarina of Time', 'Hylian Shield', 'Hookshot', 'B', 'Hard'),

(10, 'tr', 'Half-Life serisinde Gordon Freeman''ın mesleği nedir?', 'Asker', 'Fizikçi', 'Gazeteci', 'Pilot', 'B', 'Hard'),
(10, 'en', 'What is Gordon Freeman''s profession in the Half-Life series?', 'Soldier', 'Physicist', 'Journalist', 'Pilot', 'B', 'Hard'),
(10, 'es', '¿Cuál es la profesión de Gordon Freeman en la serie Half-Life?', 'Soldado', 'Físico', 'Periodista', 'Piloto', 'B', 'Hard'),

(10, 'tr', 'World of Warcraft''ta oyuncuların seçebildiği karakter sınıflarından biri aşağıdakilerden hangisidir?', 'Paladin', 'Sentinel', 'Warden', 'Templar', 'A', 'Hard'),
(10, 'en', 'Which of the following is one of the character classes players can choose in World of Warcraft?', 'Paladin', 'Sentinel', 'Warden', 'Templar', 'A', 'Hard'),
(10, 'es', '¿Cuál de las siguientes es una de las clases de personaje que los jugadores pueden elegir en World of Warcraft?', 'Paladín', 'Centinela', 'Guardián', 'Templario', 'A', 'Hard'),

(10, 'tr', 'Valve tarafından geliştirilen ve oyuncuların ''GLaDOS'' adlı yapay zekâ ile karşı karşıya geldiği oyun serisi hangisidir?', 'Half-Life', 'Portal', 'Left 4 Dead', 'Dota', 'B', 'Very Hard'),
(10, 'en', 'Which game series developed by Valve features players confronting an artificial intelligence called ''GLaDOS''?', 'Half-Life', 'Portal', 'Left 4 Dead', 'Dota', 'B', 'Very Hard'),
(10, 'es', '¿Qué serie de videojuegos desarrollada por Valve presenta a los jugadores enfrentándose a una inteligencia artificial llamada ''GLaDOS''?', 'Half-Life', 'Portal', 'Left 4 Dead', 'Dota', 'B', 'Very Hard'),

(10, 'tr', '1980 yılında piyasaya çıkan ve video oyunlarının altın çağının önemli yapımlarından biri kabul edilen ''Adventure'' oyunu hangi platform için geliştirilmiştir?', 'Atari 2600', 'Nintendo Entertainment System', 'Commodore 64', 'Sega Mega Drive', 'A', 'Very Hard'),
(10, 'en', 'For which platform was the game ''Adventure'', released in 1980 and considered one of the important titles of the golden age of video games, developed?', 'Atari 2600', 'Nintendo Entertainment System', 'Commodore 64', 'Sega Mega Drive', 'A', 'Very Hard'),
(10, 'es', '¿Para qué plataforma fue desarrollado el juego ''Adventure'', lanzado en 1980 y considerado uno de los títulos importantes de la época dorada de los videojuegos?', 'Atari 2600', 'Nintendo Entertainment System', 'Commodore 64', 'Sega Mega Drive', 'A', 'Very Hard');
