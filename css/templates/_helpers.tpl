{{/*
Expand the name of the chart.
*/}}
{{- define "css.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "css.fullname" -}}
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
{{- define "css.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "css.labels" -}}
helm.sh/chart: {{ include "css.chart" . }}
{{ include "css.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "css.selectorLabels" -}}
app.kubernetes.io/name: {{ include "css.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "css.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "css.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Pass a correct baseUrl
*/}}
{{- define "css.baseUrl" -}}
{{- if .Values.baseUrlOverride }}
{{- .Values.baseUrlOverride }}
{{- else if .Values.ingress.enabled }}
{{- printf "https://%s%s" .Values.ingress.host .Values.ingress.path}}
{{- else }}
{{- printf "%http://%s.%s/" .Release.Namespace ( include "css.fullname" . ) }}
{{- end }}
{{- end }}

