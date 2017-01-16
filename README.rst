Sapher Overlay
==============

This overlay contains:

- ebuilds for miscellaneous software I created
   - `appi <https://github.com/apinsard/sapher-overlay/tree/master/dev-python/appi>`_
   - `chuse <https://github.com/apinsard/sapher-overlay/tree/master/app-portage/chuse>`_
- ebuilds I maintain for Funtoo
   - `appi <https://github.com/apinsard/sapher-overlay/tree/master/dev-python/appi>`_
   - `chuse <https://github.com/apinsard/sapher-overlay/tree/master/app-portage/chuse>`_
   - `iwlib <https://github.com/apinsard/sapher-overlay/tree/master/dev-python/iwlib>`_
   - `qtile <https://github.com/apinsard/sapher-overlay/tree/master/x11-wm/qtile>`_
   - `pytify <https://github.com/apinsard/sapher-overlay/tree/master/media-sound/pytify>`_
   - `python-sipsimple <https://github.com/apinsard/sapher-overlay/tree/master/dev-python/python-sipsimple>`_
- and ebuilds I added for fun
   - `git-blame-someone-else <https://github.com/apinsard/sapher-overlay/tree/master/dev-vcs/git-blame-someone-else>`_


===========================
Installation via repos.conf
===========================

.. code::

  mkdir -p /var/overlays
  git clone https://github.com/apinsard/sapher-overlay.git /var/overlays/sapher
  cat > /etc/portage/repos.conf/sapher <<EOF
  [sapher]
  location = /var/overlays/sapher
  sync-type = git
  sync-uri = git://github.com/apinsard/sapher-overlay.git
  auto-sync = yes
  EOF


===========================
Installation through layman
===========================

.. code::

  emerge -a layman
  echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
  cat > /etc/layman/overlays/sapher.xml <<EOF
  <?xml version="1.0" ?>

  <repositories version="1.0">
    <repo priority="50" quality="experimental" status="unoffical">
      <name>sapher</name>
      <description>Pytony's Sapher overlay</description>
      <homepage>https://github.com/apinsard/sapher-overlay</homepage>
      <owner>
        <email>antoine.pinsard@gmail.com</email>
        <name>Antoine Pinsard</name>
      </owner>
      <source type="git">git://github.com/apinsard/sapher-overlay.git</source>
    </repo>
  </repositories>
  EOF
  layman -f
  layman -a sapher


=================================
How to Contribute to this Overlay
=================================

:author: Antoine Pinsard
:contact: antoine.pinsard@gmail.com
:language: English

Contributing to this overlay by adding new ebuilds wouldn't make any sense since
this is *my* overlay. :P However feel free to submit bug fixes / improvements.

Greetings GitHub Users!
=======================

.. _bugs.funtoo.org: https://bugs.funtoo.org

To contribute bug reports for this overlay, you can open up a GitHub issue or send
me a pull request.

If you are using ebuilds in this overlay as part of Funtoo Linux,
please also file a new issue at `bugs.funtoo.org`_.
