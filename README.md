# README

Please forgive the unoriginal project name ;-)

This project is my take on a Wikipedia style clone application, running on Ruby on Rails.
[Devise](https://github.com/plataformatec/devise) is used for authentication, while [Pundit](https://github.com/elabs/pundit) is used for authorization.  This application
also incorporates _**Stripe**_ as a payment processor for upgrading to a **Premium** account.

Premium users can create private Wikis as well as invite collaborators to assist with their wiki
project.  The Wikis are created in _Markdown_ using the [Redcarpet](https://github.com/vmg/redcarpet) gem. I also used
the [Figaro](https://github.com/laserlemon/figaro) gem to set ENV variables securely.

What made this project unique is that I started using the <code>webconsole</code> in my html as
well as <code>byebug</code> as more prominent debugging tools, is addition to <code>rails c</code>.
All-in-All, this was a very fun project!
