{{/*
AVP secret helper
*/}}
{{- define "avp.secret" -}}
{{- if .secret -}}
{{ print .secret | b32enc -}}
{{- else -}}
{{- printf "<%s>" .key -}}
{{- end -}}
{{- end -}}

{{/*
Secret value helper
If AVP enabled - returns AVP placeholder
If AVP disabled - returns base64-encoded value
*/}}
{{- define "secret.value" -}}
{{- $key := .key -}}
{{- $value := .value -}}
{{- $avp := .avp -}}
{{- if $avp -}}
{{ include "avp.secret" (dict "secret" $value "key" $key) }}
{{- else -}}
{{ $value | b64enc | quote }}
{{- end -}}
{{- end -}}

{{/*
Redis fullname helper
*/}}
{{- define "yandex-tracker-mcp.redis.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "redis" "chartValues" .Values.redis "context" $) -}}
{{- end -}}

{{/*
Redis host helper
*/}}
{{- define "yandex-tracker-mcp.redis.host" -}}
{{- if .Values.redis.enabled -}}
    {{- printf "%s-master" (include "yandex-tracker-mcp.redis.fullname" .) -}}
{{- else -}}
    {{- print .Values.externalRedis.host -}}
{{- end -}}
{{- end -}}

{{/*
Redis port helper
*/}}
{{- define "yandex-tracker-mcp.redis.port" -}}
{{- if .Values.redis.enabled -}}
    {{- print 6379 -}}
{{- else -}}
    {{- print .Values.externalRedis.port -}}
{{- end -}}
{{- end -}}

{{/*
Redis password helper
*/}}
{{- define "yandex-tracker-mcp.redis.password" -}}
{{- if .Values.redis.enabled -}}
    {{- print .Values.redis.auth.password -}}
{{- else -}}
    {{- print .Values.externalRedis.password -}}
{{- end -}}
{{- end -}}
