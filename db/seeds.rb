# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tf = TagFeed.create(hashtag: "cat", start_date: Time.at(1446922755), end_date: Time.at(1446969600), initial_tag_id: "1113191214587994748", latest_tag_id: "1113191269381946229", is_complete: false)

data = '{
      "attribution": null,
      "videos": {
        "low_bandwidth": {
          "url": "https://scontent.cdninstagram.com/hphotos-xtp1/t50.2886-16/12211420_455965604607110_1971389485_s.mp4",
          "width": 480,
          "height": 480
        },
        "standard_resolution": {
          "url": "https://scontent.cdninstagram.com/hphotos-xpa1/t50.2886-16/12222124_1156878784326576_163046939_n.mp4",
          "width": 640,
          "height": 640
        },
        "low_resolution": {
          "url": "https://scontent.cdninstagram.com/hphotos-xtp1/t50.2886-16/12211420_455965604607110_1971389485_s.mp4",
          "width": 480,
          "height": 480
        }
      },
      "tags": [
        "cute",
        "life",
        "gray",
        "nutella",
        "cat",
        "miau",
        "the",
        "graycat"
      ],
      "location": null,
      "comments": {
        "count": 0,
        "data": []
      },
      "filter": "Vesper",
      "created_time": "1446922762",
      "link": "https://instagram.com/p/9y2Y_Ck7t1/",
      "likes": {
        "count": 0,
        "data": []
      },
      "images": {
        "low_resolution": {
          "url": "https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/s320x320/e15/12224157_1676242322616047_1296043666_n.jpg",
          "width": 320,
          "height": 320
        },
        "thumbnail": {
          "url": "https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/s150x150/e15/12224157_1676242322616047_1296043666_n.jpg",
          "width": 150,
          "height": 150
        },
        "standard_resolution": {
          "url": "https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/e15/12224157_1676242322616047_1296043666_n.jpg",
          "width": 640,
          "height": 640
        }
      },
      "users_in_photo": [],
      "caption": {
        "created_time": "1446922762",
        "text": "Me vinieron a despertar UuU #cute #nutella #The #gray #cat \n#graycat #life  #miau",
        "from": {
          "username": "miikashu",
          "profile_picture": "https://scontent.cdninstagram.com/hphotos-xfp1/t51.2885-19/11917866_1485792051718234_1662068203_a.jpg",
          "id": "1967026261",
          "full_name": "Majo Valdez"
        },
        "id": "1113191274750655422"
      },
      "type": "video",
      "id": "1113191269381946229_1967026261",
      "user": {
        "username": "miikashu",
        "profile_picture": "https://scontent.cdninstagram.com/hphotos-xfp1/t51.2885-19/11917866_1485792051718234_1662068203_a.jpg",
        "id": "1967026261",
        "full_name": "Majo Valdez"
      }
    }'.to_json


data2 = '{
      "attribution": null,
      "tags": [
        "casanova",
        "cat"
      ],
      "location": null,
      "comments": {
        "count": 0,
        "data": []
      },
      "filter": "Normal",
      "created_time": "1446922755",
      "link": "https://instagram.com/p/9y2YMAmmJ8/",
      "likes": {
        "count": 0,
        "data": []
      },
      "images": {
        "low_resolution": {
          "url": "https://scontent.cdninstagram.com/hphotos-xtp1/t51.2885-15/s320x320/e35/12224617_971073232952027_1056105169_n.jpg",
          "width": 320,
          "height": 320
        },
        "thumbnail": {
          "url": "https://scontent.cdninstagram.com/hphotos-xpt1/t51.2885-15/s150x150/e35/c0.135.1080.1080/12224598_460795204124935_944714453_n.jpg",
          "width": 150,
          "height": 150
        },
        "standard_resolution": {
          "url": "https://scontent.cdninstagram.com/hphotos-xtp1/t51.2885-15/s640x640/sh0.08/e35/12224617_971073232952027_1056105169_n.jpg",
          "width": 640,
          "height": 640
        }
      },
      "users_in_photo": [],
      "caption": {
        "created_time": "1446922755",
        "text": "Dats my boy!!! #cat #Casanova",
        "from": {
          "username": "logancorsaut",
          "profile_picture": "https://igcdn-photos-b-a.akamaihd.net/hphotos-ak-xap1/t51.2885-19/s150x150/12106270_1723475577874729_1850599809_a.jpg",
          "id": "19206687",
          "full_name": "Logan Corsaut"
        },
        "id": "1113191219646325274"
      },
      "type": "image",
      "id": "1113191214587994748_19206687",
      "user": {
        "username": "logancorsaut",
        "profile_picture": "https://igcdn-photos-b-a.akamaihd.net/hphotos-ak-xap1/t51.2885-19/s150x150/12106270_1723475577874729_1850599809_a.jpg",
        "id": "19206687",
        "full_name": "Logan Corsaut"
      }
    }'.to_json

media = Medium.create(data: data, tag_id: "1113191269381946229", creation_date:"1446922762")

media2 = Medium.create(data: data2, tag_id: "1113191214587994748", creation_date:"1446922755")


tf.media << media
tf.media << media2

tf2 = TagFeed.create(hashtag: "casanova", start_date: Time.at(1446922755), end_date: Time.at(1446922755), initial_tag_id: "1113191214587994748", latest_tag_id: "1113191214587994748", is_complete: true)
tf2.media << media2

tf.save
tf2.save