
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "❌ Archivo .env no encontrado. Crea uno con GITHUB_TOKEN"
  exit 1
fi

# Variables necesarias
REPO_OWNER="Jhon-Rodriguez20"
REPO_NAME="sazon_urbano"
TAG_NAME="v1.0.0"
RELEASE_NAME="Versión 1.0.0"
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"

if [ ! -f "$APK_PATH" ]; then
  echo "❌ APK no encontrado en $APK_PATH"
  exit 1
fi

echo "🚀 Creando release en GitHub..."

RELEASE_RESPONSE=$(curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  -d @- \
  "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases" <<EOF
{
  "tag_name": "$TAG_NAME",
  "name": "$RELEASE_NAME",
  "body": "APK de lanzamiento para Android",
  "draft": false,
  "prerelease": false
}
EOF
)

RELEASE_ID=$(echo "$RELEASE_RESPONSE" | grep '"id":' | head -n 1 | awk '{print $2}' | tr -d ,)

if [ -z "$RELEASE_ID" ]; then
  echo "❌ No se pudo crear el release. Respuesta:"
  echo "$RELEASE_RESPONSE"
  exit 1
fi

echo "✅ Release creado con ID $RELEASE_ID"

echo "📦 Subiendo APK al release..."

curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/vnd.android.package-archive" \
  --data-binary @"$APK_PATH" \
  "https://uploads.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/$RELEASE_ID/assets?name=app-release.apk"

echo "✅ APK subido correctamente."