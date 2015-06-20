Sapher Overlay
==============

This overlay contains:

- ebuilds for miscellaneous software I created
- ebuilds I maintain for Funtoo

To use this overlay, the best way is to add it to layman. If you don't know
layman, installation steps are described below.

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
      <homepage>http://github.com/apinsard/sapher-overlay</homepage>
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

If you are using ebuilds in this overlay as part of Funtoo Linux (because they are
merged into the main Funtoo Linux Portage tree, for example,) then
please also open an issue at `bugs.funtoo.org`_.
