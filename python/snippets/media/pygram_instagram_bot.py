# Automate Insta
# pip install pygram
from pygram import PyGram

bot = PyGram()# Get Profile
bot.get_profile('insta profile')# Get User ID
bot.get_user_id('insta profile')# Get Posts
post = bot.get_posts('insta profile')
for x in post:
    print(x)# Get comments
com = bot.get_comments('insta profile')
for x in com:
    print(x)# Get Followers
fol = bot.get_followers('insta profile')
for x in fol:
    print(x)# Get Following
fol = bot.get_following('insta profile')
for x in fol:
    print(x)# Get Your Own Followers
bot = PyGram("your user", "your password")
fol = bot.get_followers()
for x in fol:
    print(x)# Like a Post
post = next(bot.get_posts('insta profile'))
bot.like(post)# Comment on a Post
post = next(bot.get_posts('insta profile'))
bot.comment(post, "This is a comment")
