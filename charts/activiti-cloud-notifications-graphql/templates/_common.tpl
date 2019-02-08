{{/* vim: set filetype=mustache: */}}
{{/*
Create a default tls secrtet name.
*/}}
{{- define "tlssecretname" -}}
{{- tpl (default (printf "tls-%s" (include "ingresshost" $) )  (default .Values.global.gateway.tlsSecret .Values.ingress.tlsSecret)) $ | replace "." "-" -}}
{{- end -}}

{{/*
Create a default ingress host.
*/}}
{{- define "ingresshost" -}}
{{- tpl (default (printf "%s.%s" (include "gateway-prefix" $) (include "domain" $)) ( default .Values.global.gateway.host .Values.ingress.hostName ) ) $ -}}
{{- end -}}

{{/*
Create a keycloak url.
*/}}
{{- define "keycloak-url" -}}
{{- tpl (printf "%s" (default (include "keycloak-default-url" $) .Values.global.keycloak.url )) $ -}}
{{- end -}}

{{/*
Create a default keycloak url
*/}}
{{- define "keycloak-default-url" -}}
{{- printf "%s://%s%s" (include "keycloak-proto" $) (include "keycloak-host" $) (include "keycloak-path" $) -}}
{{- end -}}

{{/*
Create a keycloak path, .i.e /auth.
*/}}
{{- define "keycloak-path" -}}
{{- default "/auth" .Values.global.keycloak.path -}}
{{- end -}}

{{/*
Create a keycloak prefix, .i.e activiti-keycloak
*/}}
{{- define "keycloak-prefix" -}}
{{- default "activiti-keycloak" (default .Values.global.config.prefix .Values.global.keycloak.prefix) -}}
{{- end -}}

{{/*
Create a gateway prefix, .i.e activiti-cloud-gateway
*/}}
{{- define "gateway-prefix" -}}
{{- default "activiti-cloud-gateway" (default .Values.global.config.prefix .Values.global.gateway.prefix) -}}
{{- end -}}

{{/*
Create a domain 
*/}}
{{- define "domain" -}}
{{- tpl (default "127.0.0.1.nip.io" .Values.global.config.domain) $ -}}
{{- end -}}

{{/*
Create a keycloak host.
*/}}
{{- define "keycloak-host" -}}
{{- tpl (default (printf "%s.%s" (include "keycloak-prefix" $) (include "domain" $)) .Values.global.keycloak.host) $ -}}
{{- end -}}

{{/*
Create a keycloak protocol
*/}}
{{- define "keycloak-proto" -}}
{{- tpl "http{{ if $.Values.global.config.tls }}s{{ end }}" $ -}}
{{- end -}}

{{/*
Create a kubernetes.io/tls-acme annotation
*/}}
{{- define "kubernetes.io/tls-acme" -}}
{{- if (default .Values.global.config.tls .Values.ingress.tls) }}
kubernetes.io/tls-acme: "true"
{{- end }}
{{- end -}}
