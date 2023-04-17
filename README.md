# Sight Navigator App
#### Description: the app allows you to search for some city's sights. Collect them and use its information for you purpose.
#### The app uses some APIs.

## Functionality
<div style="max-width: 800px; word-wrap: break-word;">
The MainPage of the app includes 2 buttons on Navigation Bar: Trip and History, stack of elements for searching and table. 

![image](https://user-images.githubusercontent.com/110242091/232394448-713248e0-bee4-4fd5-bc81-222ab6e9d3a4.png)

<center>
<br>Graph 1 -- Main Page
</center>

"AUTO" means automatic country code, it is default state for this label. If you want you can change it by clicking on it, and a code selecter will pop-up.


![image](https://user-images.githubusercontent.com/110242091/232394702-804460c1-c29d-41b9-a27b-5d1b19ef47df.png)

<br>Graph 2 -- Pop up Code Selector

Type your city and press "Let's Find"

![image](https://user-images.githubusercontent.com/110242091/232395378-a5076a8a-2f86-4b4e-8d7a-53dbd272bb85.png)

<br>Graph 3 -- The list of sights inside the table. 

You can see that some of the sights don't have images, that is totally fine, because the API is open-source and free for any users. "LoadMore" button loads a new chunck of data.


![image](https://user-images.githubusercontent.com/110242091/232396086-566c4de1-ce7b-48cc-8ab4-9cc7371857c7.png)
<br>Graph 4 -- Detailed Sight Page, shows the detailed information like title, description and map.

![image](https://user-images.githubusercontent.com/110242091/232396487-e313ddc8-cb55-42d6-badb-17d8b2997a52.png)
<br>Graph 5 -- Map demonstration

If you like the place you can add by clicking "Love/Like" button. And if the city wasn't added to the trip list before that makes a request to Google and fetch some images related to the city. That is important
because you can't go back untill all data won't be fetched!

![image](https://user-images.githubusercontent.com/110242091/232397372-7b78b141-26cd-4a4e-a5ab-9e733aa85b2d.png)

<br>Graph 6 -- Fetching status for the API.

When it is done, you can go back. 

<br>Also, you can go the history page, see and search your previous requests, click on the cell, and it will push you back and install the value to the query stripe.

![image](https://user-images.githubusercontent.com/110242091/232397833-40192cec-682e-493b-896b-436ce0921282.png)

<br>Graph 7 -- History Page. Search element works.

Because of some elements were added as favourite ones, they are available on the Trip Page.

![image](https://user-images.githubusercontent.com/110242091/232398416-767c65ee-091b-4301-a019-9ece755e0c10.png)

<br>Graph 8 -- Trip Page. 

Here, you can see cities that are containing favourite places. Clicking the cell will push to the next page called Detailed Trip Page. 

![image](https://user-images.githubusercontent.com/110242091/232399126-479a9341-7a7f-4562-ad52-04a1c44d755d.png)

<br>Graph 9 -- Detailed Trip Page shows the list of all favourite places that were added there. 

Also, you may notice Right Navigation Button "Edit". This button allows you to add the background of the city. 

![image](https://user-images.githubusercontent.com/110242091/232400070-84f11132-f3ec-461e-ab8a-aab30c774993.png)

<br>Graph 10 -- Editing Background page

Now you will have some variants of backgrounds presented as a list. Let's switch to another one. 

![image](https://user-images.githubusercontent.com/110242091/232400459-96400e78-a1dd-4837-869b-68b9c7f16c26.png)

<br> Graph 11 -- Background has changed. 

The new background was selected, let's go back. 

![image](https://user-images.githubusercontent.com/110242091/232400768-4e20c832-aab6-47fb-83a6-620e5a98ce0f.png)

<br>Graph 12 -- Pushed changes to previous page.
Here the background also has updated. 

If you click on you favourite sight, you will be pushed to Detailed Sight Page. You may dislike the place, and after pushing back this place will be deleted.

![image](https://user-images.githubusercontent.com/110242091/232401091-65c8d4ca-9552-4fe2-bc3b-7c06ba8388c1.png)

<br>Graph 13 -- The sight was deleted because it was unselected from Favourities. 

Go back again, and the avatar will be also updated in the table's content.

![image](https://user-images.githubusercontent.com/110242091/232401271-e11b6cc7-a8c0-48cf-a22c-4168e9edca33.png)

<br>Graph 14 -- Updates were pushed to the previous page.

![image](https://user-images.githubusercontent.com/110242091/232401463-48700749-a015-4902-b313-dcd3f3668cca.png)

<br>Graph 15 -- Updates were again pushed to the Main Page.

</div>


## Overall
<div style="max-width: 800px; word-wrap: break-word;">
This application presented a significant challenge for me as I utilized an API that was not optimal, requiring me to read extensive documentation for both services. Additionally, designing the layout for iOS applications proved to be quite challenging.

Through this experience, I gained a thorough understanding of the process involved in creating real-world applications. I now recognize that Google's APIs are the superior choice for map-related functionality, and I will utilize these tools in any future geolocation-based application development.
</div>
