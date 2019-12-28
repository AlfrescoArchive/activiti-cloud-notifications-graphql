{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default service name.
*/}}
{{- define "servicename" -}}
{{- $name := default (include "fullname" .) .Values.service.name -}}
{{- printf "%s" $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "notifications.rabbitmq-name" -}}
{{- if .Values.global.rabbitmq.host.value }}
{{ .Values.global.rabbitmq.host.value }}
{{- else }}
{{- printf "%s-%s" .Release.Name (.Values.rabbitmq.name | default "rabbitmq") -}}
{{- end }}
{{- end -}}

{{- define "notifications.rabbitmq-port" -}}
{{ .Values.rabbitmq.port | default 5672 }}
{{- end -}}

