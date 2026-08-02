{{/*
Expand the name of the chart.
*/}}
{{- define "powerjob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "powerjob.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Chart label values
*/}}
{{- define "powerjob.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "powerjob.labels" -}}
helm.sh/chart: {{ include "powerjob.chart" . }}
{{ include "powerjob.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "powerjob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "powerjob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Database host
*/}}
{{- define "powerjob.dbHost" -}}
{{- if eq .Values.params.dbType "postgresql" }}
{{- if .Values.postgresql.enabled }}
{{- printf "%s-postgresql" .Release.Name }}
{{- else }}
{{- .Values.params.postgresql.host }}
{{- end }}
{{- else if eq .Values.params.dbType "mysql" }}
{{- .Values.params.mysql.host }}
{{- end }}
{{- end }}

{{/*
Database port
*/}}
{{- define "powerjob.dbPort" -}}
{{- if eq .Values.params.dbType "postgresql" }}
{{- if .Values.postgresql.enabled }}
5432
{{- else }}
{{- .Values.params.postgresql.port }}
{{- end }}
{{- else if eq .Values.params.dbType "mysql" }}
{{- .Values.params.mysql.port }}
{{- end }}
{{- end }}

{{/*
Database username
*/}}
{{- define "powerjob.dbUsername" -}}
{{- if eq .Values.params.dbType "postgresql" }}
{{- if .Values.postgresql.enabled }}
powerjob
{{- else }}
{{- .Values.params.postgresql.username }}
{{- end }}
{{- else if eq .Values.params.dbType "mysql" }}
{{- .Values.params.mysql.username }}
{{- end }}
{{- end }}

{{/*
Database password
*/}}
{{- define "powerjob.dbPassword" -}}
{{- if eq .Values.params.dbType "postgresql" }}
{{- if .Values.postgresql.enabled }}
{{- .Values.postgresql.auth.password }}
{{- else }}
{{- .Values.params.postgresql.password }}
{{- end }}
{{- else if eq .Values.params.dbType "mysql" }}
{{- .Values.params.mysql.password }}
{{- end }}
{{- end }}

{{/*
Database name
*/}}
{{- define "powerjob.dbName" -}}
{{- if eq .Values.params.dbType "postgresql" }}
{{- .Values.params.postgresql.database }}
{{- else if eq .Values.params.dbType "mysql" }}
{{- .Values.params.mysql.database }}
{{- end }}
{{- end }}

{{/*
Redis host
*/}}
{{- define "powerjob.redisHost" -}}
{{- if .Values.redis.enabled }}
{{- printf "%s-redis-master" .Release.Name }}
{{- else }}
{{- .Values.params.redis.host }}
{{- end }}
{{- end }}

{{/*
Redis port
*/}}
{{- define "powerjob.redisPort" -}}
{{- if .Values.redis.enabled }}
6379
{{- else }}
{{- .Values.params.redis.port }}
{{- end }}
{{- end }}

{{/*
Redis password
*/}}
{{- define "powerjob.redisPassword" -}}
{{- if .Values.redis.enabled }}
{{- .Values.redis.auth.password }}
{{- else }}
{{- .Values.params.redis.password }}
{{- end }}
{{- end }}

{{/*
Build PARAMS env value
*/}}
{{- define "powerjob.params" -}}
{{- $dbType := .Values.params.dbType -}}
--oms.db-type={{ $dbType }}
--spring.datasource.core.jdbc-url=jdbc:{{ $dbType }}://{{ include "powerjob.dbHost" . }}:{{ include "powerjob.dbPort" . }}/{{ include "powerjob.dbName" . }}
--spring.datasource.core.username={{ include "powerjob.dbUsername" . }}
--spring.datasource.core.password={{ include "powerjob.dbPassword" . }}
--oms.cache.type={{ .Values.params.omsCacheType }}
{{- if eq .Values.params.omsCacheType "redis" }}
--spring.data.redis.host={{ include "powerjob.redisHost" . }}
--spring.data.redis.port={{ include "powerjob.redisPort" . }}
--spring.data.redis.password={{ include "powerjob.redisPassword" . }}
{{- end }}
{{- if .Values.params.mongodb.enabled }}
--oms.mongodb.enable=true
--spring.data.mongodb.uri=mongodb://{{ .Values.params.mongodb.username }}:{{ .Values.params.mongodb.password }}@{{ .Values.params.mongodb.host }}:{{ .Values.params.mongodb.port }}/{{ .Values.params.mongodb.database }}
{{- end }}
{{- if .Values.params.mail.enabled }}
--spring.mail.host={{ .Values.params.mail.host }}
--spring.mail.port={{ .Values.params.mail.port }}
--spring.mail.username={{ .Values.params.mail.username }}
--spring.mail.password={{ .Values.params.mail.password }}
--spring.mail.properties.mail.smtp.ssl.enable={{ .Values.params.mail.ssl }}
{{- end }}
{{- end }}
