{% from "zabbix/map.jinja" import zabbix with context -%}
{% set settings = salt['pillar.get']('zabbix', {}) -%}

# Skip zabbix user and groups for Windows
{% if salt['grains.get']('os_family') != 'Windows' -%}
zabbix_user:
  user.present:
    - name: {{ zabbix.user }}
    - gid_from_name: True
    - groups: {{ settings.get('user_groups', []) }}
    - require:
      - group: zabbix_group


zabbix_group:
  group.present:
    - name: {{ zabbix.group }}

{%- endif %}
