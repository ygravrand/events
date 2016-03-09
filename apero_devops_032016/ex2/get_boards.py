from kansha.user.models import DataUser

user = session.query(DataUser).get(('user1', u'application'))
print 'board =', user.boards[0].uri