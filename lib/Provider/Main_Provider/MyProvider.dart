import 'package:flutter/cupertino.dart';

List NewsHEAD=["Nursing home wait list hits record high — and is now\n"
    "holding up 500 hospital beds",
  "Nursing home wait list hits record high — and is now\n"
      "holding up 500 hospital beds",
  "Nursing home wait list hits record high — and is now\n"
      "holding up 500 hospital beds"
];

List Date = ["27 May 2023",
  "27 May 2023",
  "27 May 2023"
];

String news1 = "The number of New Brunswick seniors waiting to get into a nursing home has reached a record high, "
    "and nearly 500 of the people on that list are waiting in hospital beds that could be used for acute care, "
    "according to a seniors' advocate."
    "Cecile Cassista, executive director of the Coalition for Seniors and Nursing Home Residents' Rights, "
    "said 833 people are on the waitlist as of November. Of those, approximately 483 are in hospital"
    "That's up from 782 and 455 in October, according to data from the Department of Social Development."
    "Cassista described the numbers as 'astounding' and 'very upsetting."
    "They're the highest they've been since she started tracking them in 2006-07, she said."
    "I'm really… frustrated because the government is not taking the responsible role to make sure that our most "
    "vulnerable seniors are protected. And it's just like they've been forgotten."
    "The latest statistics come as the triple threat of respiratory illnesses — the flu, "
    "respiratory syncytial virus, known as RSV, and COVID-19 — increases the strain on the hospital system.";

String faq = """How will you help build life skills?
Do I have access to a telephone where I can speak in private?
Do I have access to the internet?
Are you able to provide me with a menu?
Will you be able to accommodate my special diet?
What time do you provide meals?
Do you have a bedtime or a quiet time?
What training does your staff have?
What activities do you offer?
When experiencing challenging behaviours from residents, how would operator/staff handle the situation?
How do you transport clients?
Is there local transportation handy to your home?
Will you transport to religious venues?
Do you have visiting hours or open door policy?
Can I visit my loved one privately in their room or only inn open common areas?
Will it be a single room or shared room?
Do you charge more than the government rate?
Do you provide cable in the bedrooms?
Do you have stairs in your building that I will have to use?
Can I bring my own personal belongings?""";


String boardmmbrdescription = """Ann Mary has been the President of the Homely Special Care Home Association 
for many years. She is a strong advocate for community-based services. Ann works hard to forge productive 
relationships with government, and other community partners, to strengthen the sector overall. Her and her 
husband own and operate a small Special Care Home in Saint John. The past 25 years in this occupation has 
given her a comprehensive knowledge base of the challenges faced by operators and their employees as they 
strive to deliver quality services to clients.""";

List<String> speakerimages =
[
  "assets/EventSpeakers/elissa.jpg",
  "assets/EventSpeakers/azadmoopen.webp",
  "assets/EventSpeakers/Tejasvi.png",
];

List<String> speakernames =
[
  "Dr.Elissa Hatherly\n     CEO @ \nNBH Medicals.",
  "Dr. Azaad Moopan\n    Chairman \nAster DM Medicals",
  "Tejasvi Ravi\nPrincipal @ \nLightrock",
];

class MyProvider extends ChangeNotifier
{
  int currentIndex = 0;

  void changeindex(int index)
  {
    currentIndex = index;
    notifyListeners();
  }
}