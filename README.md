## About application

**Herohu:** https://lunch-ordering-hladkyi.herokuapp.com

**Admin:**

email: admin@example.com

password: '123456'

**User:**

email: user@example.com

password: '123456'


## API:

You must have an account to use the API. To create it, go to: https://lunch-ordering-hladkyi.herokuapp.com/users/sign_up

**To receive a token - enter the command:**
```bash
curl -X POST https://lunch-ordering-hladkyi.herokuapp.com/api/v1/authenticate -H 'content-type: multipart/form-data' -F 'email=your_email@example.com' -F 'password=your_password'
```

**To get a list of all orders - enter the command:**
```bash
curl https://lunch-ordering-hladkyi.herokuapp.com/api/v1/orders -H 'Authorization: Bearer your_token'
```
* The Administrator will receive a list of all orders for the current day. The User will receive a list of his orders.

**To get a list of available items - enter the command:**
```bash
curl https://lunch-ordering-hladkyi.herokuapp.com/api/v1/items -H 'Authorization: Bearer your_token'
```

**To create an order, enter:**
```bash
curl https://lunch-ordering-hladkyi.herokuapp.com/api/v1/orders -H 'Authorization: Bearer your_token' -d 'items_ids=[1,2,3]'
```

WARNING! There must be one position from each category!# lunch-ordering-app
# lunch-ordering-app
