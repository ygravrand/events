from kansha.user.models import DataUser

user = session.query(DataUser).get(('user1', u'application'))
print user.boards[0].uri