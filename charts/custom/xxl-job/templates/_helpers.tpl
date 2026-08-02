{{/*
Expand the name of the chart.
*/}}
{{- define "xxl-job.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "xxl-job.fullname" -}}
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
{{- define "xxl-job.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "xxl-job.labels" -}}
helm.sh/chart: {{ include "xxl-job.chart" . }}
{{ include "xxl-job.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "xxl-job.selectorLabels" -}}
app.kubernetes.io/name: {{ include "xxl-job.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
MySQL JDBC URL
*/}}
{{- define "xxl-job.jdbcUrl" -}}
{{- if .Values.params.jdbcUrl }}
{{- .Values.params.jdbcUrl }}
{{- else if .Values.mysql.enabled }}
{{- printf "jdbc:mysql://%s-mysql:3306/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai" .Release.Name }}
{{- end }}
{{- end }}

{{/*
MySQL username
*/}}
{{- define "xxl-job.jdbcUsername" -}}
{{- if .Values.params.jdbcUsername }}
{{- .Values.params.jdbcUsername }}
{{- else if .Values.mysql.enabled }}
xxljob
{{- end }}
{{- end }}

{{/*
MySQL password
*/}}
{{- define "xxl-job.jdbcPassword" -}}
{{- if .Values.params.jdbcPassword }}
{{- .Values.params.jdbcPassword }}
{{- else if .Values.mysql.enabled }}
{{- .Values.mysql.auth.password }}
{{- end }}
{{- end }}
