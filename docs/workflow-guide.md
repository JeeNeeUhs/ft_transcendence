# İş Akış Rehberi

1. Yapılacak iş ve kapsamı belirlendikten sonra Kanban board veya repository sayfasındaki **Issues** sekmesinden
işe uygun template kullanılarak yeni bir issue oluşturulur. Issue içeriğinde problemin veya eklenecek
özelliğin detayları net bir şekilde belirtilmelidir.

2. Issue oluşturulduktan ve ayarları (etiketler vs.) doğru bir şekilde yapıldıktan sonra Kanban board üzerinde
iş **Ready** kolonuna taşınır. Bu kolon işin planlandığını ve geliştirilmeye hazır olduğunu ifade eder.

4. İş geliştirmeye başlanacağı zaman Kanban board üzerinde **In Progress** kolonuna alınır. Ardından iş için
geliştirme yapılacak yeni bir branch oluşturulur. İş ile alakalı tüm geliştirmeler sadece bu branch üzerinde yapılır. \
  \- **Normal Geliştirmeler (feature, refactor, bug vs.):** Yeni branch her zaman `dev` branch'inden oluşturulur. \
  \- **Acil Çözümler (hotfix):** Hemen düzeltilmesi gereken acil hatalar için istisnai olarak `master` branch'inden oluşturulur.

5. Branch üzerinde geliştirmeler tamamlandıktan sonra, ilgili branch'ten `dev` branch'ine bir **Pull Request (PR)** açılır.
(Eğer bu bir hotfix ise, hem `master` hem de `dev` branch'lerine pull request açılmalıdır.)
PR sayfasında aşağıdaki alanların eksiksiz doldurulması zorunludur: \
  \- **Assignees:** İşi geliştiren kişi veya kişiler. \
  \- **Reviewers:** Kodu incelemesi beklenen ekip arkadaşları. \
  \- **Development:** Geliştirilen işe ait Issue, ilgili PR'a bağlanır (Böylece PR onaylandığında issue otomatik olarak güncellenebilir).

6. PR oluşturulduktan sonra iş Kanban board üzerinde **In Review** kolonuna taşınır. Atanan reviewer'lar kodun uygunluğunu ve çalışabilirliğini
inceler. Eğer bir düzeltme gerekiyorsa PR üzerine yorum bırakılır. Geliştirici istenen değişiklikleri yaparak aynı branch'e commit atmaya devam eder.

7. Kod incelemesinden onay alan PR, `dev` branch'ine merge edilir. Bu aşamada issue eğer ilgili PR'a bağlanıldıysa
Kanban board üzerinde çalışan workflow bu işi otomatik olarak **Done** kolonuna sürükleyecektir. 

8. `dev` branch'inde toplanan geliştirmeler stabil bir hale geldiğinde, `dev` branch'inden `master` branch'ine bir PR oluşturulup
geliştirmeler stabil olan `master` branch'ine taşınır.
