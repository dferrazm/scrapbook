## USERS ###

# Admin user
admin = User.create(username: 'admin', password: 'change123', role: Role::ADMIN)
# Normal user
user = User.create(username: 'user', password: 'change123', role: Role::NORMAL)
# Guest user
guest = User.create(username: 'guest', password: 'change123', role: Role::GUEST)

## MOODS ##

sad = Mood.create(description: 'Sad')
happy = Mood.create(description: 'Happy')

## SCRAPNOTES ##

Scrapnote.create(user: user,  mood: sad,   content: "User: I'm sad ...")
Scrapnote.create(user: user,  mood: happy, content: "User: I'm happy ...")
Scrapnote.create(user: admin, mood: sad,   content: "Admin: I'm sad ...")
Scrapnote.create(user: admin, mood: happy, content: "Admin: I'm happy ...")
Scrapnote.create(user: guest, mood: sad,   content: "Guest: I'm sad ...")
Scrapnote.create(user: guest, mood: happy, content: "Guest: I'm happy ...")
