{{/*
Expand the name of the chart.
*/}}
{{- define "community-solid-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "community-solid-server.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "community-solid-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "community-solid-server.labels" -}}
helm.sh/chart: {{ include "community-solid-server.chart" . }}
{{ include "community-solid-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "community-solid-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "community-solid-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "community-solid-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "community-solid-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Pass a correct baseUrl
*/}}
{{- define "community-solid-server.baseUrl" -}}
{{- if .Values.baseUrlOverride }}
{{- .Values.baseUrlOverride }}
{{- else if .Values.ingress.enabled }}
{{- printf "http://%s%s" .Values.ingress.host .Values.ingress.path}}
{{- else }}
{{- printf "http://%s.%s/" ( include "community-solid-server.fullname" . ) .Release.Namespace }}
{{- end }}
{{- end }}