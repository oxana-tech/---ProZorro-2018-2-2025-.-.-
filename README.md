# ПЕТ-ПРОЕКТ "ProZorro: Аналіз закупівель Львова 2018–2квартал 2025 р.р.
### Тип: Аналітичний дашборд / Дослідження даних
### Інструменти: Tableau Public, SQL, Python
### Дані: Відкриті дані платформи ProZorro, Львівська міська рада
### Період: 2018–2025 р.р.
### Переглянути на Tableau Public  <a href="https://public.tableau.com/views/ProZorro/Story1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link" >Дашборд</a>
# Про що цей проєкт
### Це комплексне дослідження системи публічних закупівель Львівської міської ради на основі відкритих даних ProZorro. Проєкт охоплює 231 607 закупівельних процедур загальним обсягом 53,8 млрд грн і відповідає на одне головне запитання: наскільки ефективна та прозора система закупівель і де приховані ризики?
Дослідження побудоване як аналітична історія з чотирьох взаємопов'язаних дашбордів — від загальної фінансової картини до виявлення конкретних аномалій і зон корупційного ризику.

# Дослідження використані для аналітичної статті "Ризики та антикорупційні індикатори у закупівлях Львівської міської ради: порівняння з міжнародними практиками"
## Вступ
### Система Prozorro стала символом відкритості державних закупівель в Україні.
Аналіз закупівель Львівської міської ради за 2018–2025 рр. показує, що навіть на локальному рівні можна оцінити ризики концентрації, неконкурентності та ефективності за міжнародними стандартами.
<img width="823" height="75" alt="image" src="https://github.com/user-attachments/assets/5d9fc72c-d84e-4043-b2d9-354af5f41c38" />

## 1. Міжнародні стандарти антикорупційного моніторингу
### 1.1 Transparency International — Індекс сприйняття корупції (CPI)
 <a href=" https://www.transparency.org/en/cpi">Transparency International</a>
 Transparency International визначає корупцію як системну проблему, що проявляється через:
низьку конкуренцію в тендерах,
повторюваних постачальників,
відсутність економії,
концентрацію контрактів у вузькому колі учасників.
<img width="947" height="413" alt="image" src="https://github.com/user-attachments/assets/4f1c5cf9-ca3c-4456-a4e4-0ddfcc416bff" />

### У контексті Львова ці фактори частково підтверджуються:
у 2023 р. HHI = 2005, а 181 замовник мав показник HHI > 2500, що свідчить про високий рівень концентрації.

<img width="752" height="252" alt="image" src="https://github.com/user-attachments/assets/5f8d0ea4-0dc8-4f2b-940c-64a4d61ab32b" />

## 1.2 Open Contracting Partnership — Red Flags у закупівлях/
 <a href="https://www.open-contracting.org/resources/red-flags/">Open Contracting Partnership</a>

### Open Contracting Partnership пропонує набір “червоних прапорців”, які сигналізують про ризики:
-менше двох учасників у тендері,
-неконкурентні процедури,
-повторювані переможці,
-аномальні строки контрактів.
<img width="260" height="357" alt="image" src="https://github.com/user-attachments/assets/3db68bf2-a939-4037-8062-0d75be2e390b" />
<img width="259" height="308" alt="image" src="https://github.com/user-attachments/assets/b484aede-d5f2-44bb-919a-b62b7157154e" />

### Львівська міська рада вже відповідає цим принципам — дані Prozorro відкриті, а аналітика доступна через BI модуль.
<img width="546" height="363" alt="image" src="https://github.com/user-attachments/assets/5f7efc25-c068-44bb-ace0-c99525aa5ee3" />

# 2. Ризикові індикатори у закупівлях Львова
## 2.1 Висока концентрація ринку
### HHI > 2500 у 181 замовника — це міжнародний поріг монополізації (за стандартами OECD та DOJ USA).
Найвищі показники спостерігаються у сферах енергетики, транспорту та комунальних послуг.
<img width="734" height="330" alt="image" src="https://github.com/user-attachments/assets/a5a4e403-9ef3-43ec-925b-60ad9e10ed67" />

## 2.2 Неконкурентні процедури
### Частка переговорних процедур — 9.9 %,
Частка неконкурентних закупівель — 29 %,
У деяких категоріях (медичне обладнання, будівництво) — понад 70 %.
<img width="737" height="338" alt="image" src="https://github.com/user-attachments/assets/76ae24eb-5ed1-4c46-b741-3f5646c0afc8" />

# 2.3 Повторювані постачальники
### Топ 10 постачальників отримали понад 60 % контрактів.
Це відповідає міжнародному “red flag” — “repeated winners”.

<img width="746" height="293" alt="image" src="https://github.com/user-attachments/assets/21180e06-963e-45e5-b6f8-9ca36dd5299e" />

# 3. Порівняння з міжнародними практиками
<img width="397" height="194" alt="image" src="https://github.com/user-attachments/assets/0d9dfdae-f8b8-4199-9898-4606fb5fe1e7" />
<img width="750" height="291" alt="image" src="https://github.com/user-attachments/assets/afa0e158-d378-4315-a9e0-b6eaaae7dcbe" />

# 4. Висновки
### Львівська міська рада демонструє високий рівень відкритості даних і використання аналітики ризиків.
Risk Score за методикою Prozorro відповідає міжнародним стандартам (OECD, OCP, TI).
Основні ризики — висока концентрація, мала кількість учасників, повторювані постачальники.
Україна впровадила автоматичні індикатори ризику раніше, ніж більшість країн ЄС.
Наступний крок — зниження концентрації через стимулювання нових учасників і розширення конкуренції.
<img width="733" height="260" alt="image" src="https://github.com/user-attachments/assets/7d319e2c-f056-435e-9a1b-b180734c95b0" />

## 5. Джерела
### Transparency International 
<a href="https://www.transparency.org/en/cpi">Transparency International</a>

### Open Contracting Partnership 
<a href="https://www.open-contracting.org/resources/red-flags/">Open Contracting Partnership</a>

### OECD 
<a href="https://www.open-contracting.org/wp-content/uploads/2024/12/OCP2024-RedFlagProcurement-1.pdf">OECD</a>

### Prozorro 
<a href="https://data.gov.ua/dataset?tags=%D0%BF%D1%83%D0%B1%D0%BB%D1%96%D1%87%D0%BD%D1%96+%D0%B7%D0%B0%D0%BA%D1%83%D0%BF%D1%96%D0%B2%D0%BB%D1%96">Prozorro</a>












