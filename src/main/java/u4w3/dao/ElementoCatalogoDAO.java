package u4w3.dao;

import u4w3.exception.*;

import u4w3.entities.ElementoCatalogo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.List;

public class ElementoCatalogoDAO {

    private final EntityManager em;

    public ElementoCatalogoDAO(EntityManager em) {
        this.em = em;
    }

    public void save(ElementoCatalogo elemento) throws ErroreGenericoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(elemento);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante il salvataggio dell'elemento: " + e.getMessage());
        }
    }

    public ElementoCatalogo findById(Long id) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            ElementoCatalogo elemento = em.find(ElementoCatalogo.class, id);
            if (elemento == null) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato con ID: " + id);
            }
            return elemento;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per ID: " + e.getMessage());
        }
    }

    public boolean checkByISBN(String isbn) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            ElementoCatalogo check = em
                    .createQuery("SELECT e FROM ElementoCatalogo e WHERE e.codiceISBN = :isbn", ElementoCatalogo.class)
                    .setParameter("isbn", isbn)
                    .getSingleResult();
            // Se trova qualcosa, ritorna true
            return true;
        } catch (NoResultException e) {
            // Se non trova nulla, ritorna false
            return false;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per ISBN: " + e.getMessage());
        }
    }

    public ElementoCatalogo findByISBN(String isbn) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            return em.createQuery("SELECT e FROM ElementoCatalogo e WHERE e.codiceISBN = :isbn", ElementoCatalogo.class)
                    .setParameter("isbn", isbn)
                    .getSingleResult();
        } catch (NoResultException e) {
            throw new ElementoNonTrovatoException("Nessun elemento trovato con ISBN: " + isbn);
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per ISBN: " + e.getMessage());
        }
    }

    public List<ElementoCatalogo> findByAnno(int anno) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            List<ElementoCatalogo> risultati = em
                    .createQuery(
                            "SELECT e FROM ElementoCatalogo e WHERE e.annoPubblicazione = :anno ORDER BY e.annoPubblicazione",
                            ElementoCatalogo.class)
                    .setParameter("anno", anno)
                    .getResultList();
            if (risultati.isEmpty()) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato per l'anno: " + anno);
            }
            return risultati;
        } catch (ElementoNonTrovatoException e) {
            throw e;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per l'anno: " + e.getMessage());
        }
    }

    public List<ElementoCatalogo> findByAutore(String autore)
            throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            List<ElementoCatalogo> risultati = em
                    .createQuery(
                            "SELECT e FROM ElementoCatalogo e WHERE LOWER(e.autore) LIKE :autore ORDER BY e.autore",
                            ElementoCatalogo.class)
                    .setParameter("autore", "%" + autore.toLowerCase() + "%")
                    .getResultList();
            if (risultati.isEmpty()) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato con autore: " + autore);
            }
            return risultati;
        } catch (ElementoNonTrovatoException e) {
            throw e;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per autore: " + e.getMessage());
        }
    }

    public List<ElementoCatalogo> findByTitolo(String titolo)
            throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            List<ElementoCatalogo> risultati = em
                    .createQuery(
                            "SELECT e FROM ElementoCatalogo e WHERE LOWER(e.titolo) LIKE :titolo ORDER BY e.titolo",
                            ElementoCatalogo.class)
                    .setParameter("titolo", "%" + titolo.toLowerCase() + "%")
                    .getResultList();
            if (risultati.isEmpty()) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato con titolo: " + titolo);
            }
            return risultati;
        } catch (ElementoNonTrovatoException e) {
            throw e;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per titolo: " + e.getMessage());
        }
    }

    public void delete(ElementoCatalogo elemento) throws ErroreGenericoException, ElementoNonTrovatoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            if (elemento == null) {
                throw new ErroreGenericoException("Elemento non passato alla funzione di eliminazione");
            }
            if (em.find(ElementoCatalogo.class, elemento.getId()) == null) {
                throw new ElementoNonTrovatoException("Elemento non trovato nel database");
            }
            em.remove(elemento);
            transaction.commit();
        } catch (ElementoNonTrovatoException e) {
            throw e;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante l'eliminazione dell'elemento: " + e.getMessage());
        }
    }

    public List<ElementoCatalogo> findAll() throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            List<ElementoCatalogo> risultati = em
                    .createQuery("SELECT e FROM ElementoCatalogo e", ElementoCatalogo.class).getResultList();
            if (risultati.isEmpty()) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato.");
            }
            return risultati;
        } catch (ElementoNonTrovatoException e) {
            throw e;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante il recupero di tutti gli elementi: " + e.getMessage());
        }
    }

    public List<ElementoCatalogo> findAllByTipo(String tipo)
            throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            // Converto il tipo in minuscolo per evitare problemi di case sensitivity
            tipo = tipo.toLowerCase();

            List<ElementoCatalogo> risultati = em
                    .createQuery("SELECT e FROM ElementoCatalogo e WHERE LOWER(e.tipo) = :tipo ORDER BY e.titolo",
                            ElementoCatalogo.class)
                    .setParameter("tipo", tipo)
                    .getResultList();
            if (risultati.isEmpty()) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato per il tipo: " + tipo);
            }
            return risultati;
        } catch (ElementoNonTrovatoException e) {
            throw e;
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per tipo: " + e.getMessage());
        }
    }
}