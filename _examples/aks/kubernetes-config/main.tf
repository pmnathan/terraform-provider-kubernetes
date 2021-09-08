terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
  }
}

resource "kubernetes_namespace" "test2" {
  metadata {
    name = "test2"
  }
}

resource "kubernetes_namespace" "test3" {
  metadata {
    name = "test3"
  }
}


resource "kubernetes_namespace" "test4" {
  metadata {
    name = "test4"
  }
}

resource "kubernetes_namespace" "test5" {
  metadata {
    name = "test5"
  }
}

resource "kubernetes_namespace" "test6" {
  metadata {
    name = "test6"
  }
}

resource "kubernetes_deployment" "test" {
  metadata {
    name = "test"
    namespace= kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "test"
      }
    }
    template {
      metadata {
        labels = {
          app  = "test"
        }
      }
      spec {
        container {
          image = "nginx:1.19.4"
          name  = "nginx"

          resources {
            limits = {
              memory = "512M"
              cpu = "1"
            }
            requests = {
              memory = "256M"
              cpu = "50m"
            }
          }
        }
      }
    }
  }
}

resource helm_release nginx_ingress {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "local_file" "kubeconfig" {
  content = var.kubeconfig
  filename = "${path.root}/kubeconfig"
}
